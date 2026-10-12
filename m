Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC9C3AC0F0;
	Mon, 12 Oct 2026 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799288; cv=none; b=KvEpC0C0XrdrC/SUrqm7Y/Iv/B7Qgy6WYBr6gQIQGMPqgGfwbrlr7Uwzed0wO0C1t1MH2+uSrVljwBxQ+NrxtpjiOv7FiCuFy1M28oVNM22mlM6p9FqEbmqXMpnHU2rCKEBcdWWMxI5bgWBVtTV1/tTgntnxIHCIhh+eEmXKe8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799288; c=relaxed/simple;
	bh=qT47KZZqPzMezaTCqQ7sHJiHTWRRK3Felo7O1F82g8o=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AVwIwTmiF6oniufNWsov1JmdXHs/U3Kq46ZiLOi/NZPD7Sdp5crQGTe97PSnYjbtwaAUsatoYFCtGnREQRTAmMYVgpIgKIULuELpLyJsr/85wpQI3+SKdvUKBoKX5qG5QYAlByZhNoA/ymdVPTw8XLqtfCYlBYn9mabjttNmhCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9V2Gkac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9V2Gkac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACC41F0089B;
	Mon, 12 Oct 2026 10:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791799282;
	bh=bkZFqXrBK2oowRQLizf57Luwn8acr/lrYHsk/m/NRRk=;
	h=From:To:Subject:In-Reply-To:References:Date;
	b=R9V2GkacqCxdIJ7U4OUqEeedA3aA2IyiX/COxiL6M8wQqE9tEEDVuFeE+1VtJ+SRb
	 tYt6WVfGz3EJsLbL3akVxsLwanaEcTm1n0WLv1uink7kWegKkmi42uLkz9pOUP6hZA
	 YjF6Za3BhFKgBxqaihrxGXOmZz+wMyOvWqv9+ubiyPjnIy04Y9U12pk6Y/EIymBdIZ
	 xvxtFLZSDkjQwqf14laW87OABxzjG61PvwmbIxIypLlMc+Hf11BTCq6El5c9D8YRMc
	 Cp0npplb07TsgDmOVNQ8N+PvcdO3qRDBnIEDBB5osXkiH3aq+RMghzrQzmvBVXOwlu
	 hFXJb+5izP3nQ==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v7 16/16] PCI/TSM: wait for vdevice contexts before
 removing a DSM
In-Reply-To: <sashiko-outbox-163687@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-17-aneesh.kumar@kernel.org>
 <sashiko-outbox-163687@kernel.org>
Date: Mon, 12 Oct 2026 15:31:17 +0530
Message-ID: <yq5atsmr44r6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] PCI/TSM: UAF due to bypassed drain wait in pci_tsm_unregister()
> --
>
> commit 70b40a7c8d41eb1bbe070cea07e7f252f47338e8
> Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
>     PCI/TSM: wait for vdevice contexts before removing a DSM
>     
>     A PF0 DSM can be removed while a sibling function still has a vdevice.
>     The context pins both the pci dev, but those references do not keep the
>     PF0 DOE mailbox alive. Ignoring -EBUSY from link disconnect lets PCI
>     continue to pci_doe_destroy(), leaving the vdevice with a stale mailbox
>     pointer.
>
>> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
>> index c8603867e09df..8aa74ba31932b 100644
>> --- a/drivers/pci/tsm.c
>> +++ b/drivers/pci/tsm.c
> [ ... ]
>> @@ -751,8 +769,44 @@ static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
>>  
>>  void pci_tsm_destroy(struct pci_dev *pdev)
>>  {
>> -	guard(rwsem_write)(&pci_tsm_rwsem);
>> +	struct pci_tsm_pf0 *pf0 = NULL;
>> +	struct completion *drained;
>> +	bool interrupted = false;
>> +	long rc;
>> +
>> +	down_write(&pci_tsm_rwsem);
>> +	if (pdev->tsm && is_link_tsm(pdev->tsm->tsm_dev) &&
>> +	    is_pci_tsm_pf0(pdev)) {
>> +		pf0 = to_pci_tsm_pf0(pdev->tsm);
>> +		drained = &pf0->contexts_drained;
>> +		mutex_lock(&pf0->lock);
>> +		pf0->removing = true;
>> +		mutex_unlock(&pf0->lock);
>> +
>> +		/* An unused DSM may never have completed contexts_drained. */
>> +		rc = pf0->context_users ?
>> +			try_wait_for_completion(drained) : 1;
>> +		/* Context release needs the read side of pci_tsm_rwsem. */
>> +		up_write(&pci_tsm_rwsem);
>> +		while (rc <= 0) {
> [ ... ]
>> +			if (!rc)
>> +				pci_warn(pdev, "TSM connection is in use, waiting for vdevices\n");
>> +		}
>> +		down_write(&pci_tsm_rwsem);
>> +	}
>>  	__pci_tsm_destroy(pdev, NULL);
>> +	up_write(&pci_tsm_rwsem);
>>  }
>
> [Severity: High]
> This adds the context drain wait loop when the PCI device is destroyed, but
> what happens when the TSM provider device is unbound and calls
> pci_tsm_unregister() first?
>
> Looking at pci_tsm_unregister() in drivers/pci/tsm.c, it directly calls
> __pci_tsm_destroy(pdev, tsm_dev) bypassing this new wait loop:
>
> drivers/pci/tsm.c:pci_tsm_unregister() {
>     ...
> 	for_each_pci_dev_reverse(pdev)
> 		__pci_tsm_destroy(pdev, tsm_dev);
> }
>
> If contexts are active, __pci_tsm_destroy() skips clearing pdev->tsm
> because pci_tsm_disconnect() will return -EBUSY:
>
> drivers/pci/tsm.c:__pci_tsm_destroy() {
>     ...
> 	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev)) {
> 		if (pci_tsm_disconnect(pdev))
> 			pci_warn(pdev, "TSM connection is still in use\n");
> 	} else {
>     ...
> }
>
> tsm_unregister() then drops its reference, and the provider frees the
> underlying pci_tsm memory. Later, when the PCI core calls this modified
> pci_tsm_destroy(), won't it dereference the already freed pdev->tsm and
> pdev->tsm->tsm_dev pointers here?
>

With this series, vdevices hold a reference to their parent vIOMMU,
which pins arm-cca-host. sysfs unbind is disabled, and the SMCCC
provider device has no hot-unplug path.

-aneesh
