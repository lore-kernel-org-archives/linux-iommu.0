Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896F1388862
	for <iommu@lists.linux.dev>; Sat, 10 Oct 2026 03:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791602866; cv=none; b=LZWp2kKTi5mOX0GW0bcTtLTk/d1yV6EDoQR4UNTpuC97lxD2tnxEUXa17qT4pCHmcbvjcbWyB0KAY7V4nrnWko9tPvSMeRtPdWs9WDlO4Wn4awfE08BRHQeyb+XfF/W9/PH0zpMH3Nx2TPAj5c0qZyOchP9484kunaHBA9TY58U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791602866; c=relaxed/simple;
	bh=bY/lFkbzuL0wWuJJ/NycYQnLQsKUteIgt6DpWGrrrTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQv0J+uTmvAZbpA2tRG/dtE06zJVEWFv9F+ldfuO5n+zsgERE/yKiTYT9jFuZySv9sLHJzXMiWXuuHs6i/sGa1BVTZKhUSr9QwPev2tShAgabBpJD9imrDSdd8/GTsDy/J4Rmexn8/0V7iCRqfpvCC7VyRHoFZCIzbwTLkZuQVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nR7d/F/H; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nR7d/F/H"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so5625ad.1
        for <iommu@lists.linux.dev>; Fri, 09 Oct 2026 20:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791602865; x=1792207665; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LXRGckOxSl9+/CEvwJi4Okj+sE0MNttNQkzUsECyRvQ=;
        b=nR7d/F/Hu6Ejk8XCf1Ge2ZJXr/xPUObFznmqAqw967TWiV3pQTM9OdESUpVjjJqARC
         cSJO3O9VedGhcybI/GGtLOxnjEjdpu/WkCRwmH1PLNzCb1MBO09fKt8U/RDIG5jp4i8N
         I4hKbBG6KXs20ToquHqzeP6rHW4c/K5jsl7gmybgJoMibegu2CTqLtMWhlvyQeLcnCug
         iIcwQ7+bXxQdeP/dnq1+ROaFOTTTzHAhQOUwalC1GlatJKa34aN4W2oKONn6Zif3b3nz
         y36Q5VryUccQbYEKpq0o5ZP5r33i9yGuhpzMZdmL6aYEKSk6d6k/4V6wRQjsEyNEZQHM
         Ol8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791602865; x=1792207665;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LXRGckOxSl9+/CEvwJi4Okj+sE0MNttNQkzUsECyRvQ=;
        b=b7g2j5abnj4FiPIDZP3YLU+KmiOWswHyk5WC+eYp6VBimre+XnZBeLfxsM0/dRjnlG
         DQBj+iSOd18l/IRidzaeXbhtgq6wVCjzpDm2vqTi8K4bUrm44Zcr2ICnSpk1uFPGe84o
         v9/RR8VX03tveu1SP81UATS6Hi1XUN08PwVc6Ywvhp19u4PxhItKgZJy2bQlFw2HiUSu
         BYrAWZwviOiuU41KO+VNHFLt9CLqleFjlAfHafhiTsCyBBtuMiP/Y5O04HBDXy1Lrckp
         c5XYNdCujiWjmiU8hNXxxLeWpylaIoGKGHSSNonPeVfvyXAeVizk3DpDAP5oGBbXlHVU
         NLHw==
X-Forwarded-Encrypted: i=1; AKwUvBytr7uHtJQTDqUUjI+1VohJgtyC4mkkbevAhFIICFIFLyo4Te0V9jAl9PQ98KRsG5BWbLPPVA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIvUOohgVb9WjzU0xAIo8BvYt9mhgQI6FyOZUJdy+8uf++HwldI
	qEWPjpRe2YcouDUql8nXA36Bsx5khC79s/XKaNQq6kcnZiJaihV/dwz7Rk6HRr6lHw==
X-Gm-Gg: AYBFou0JTt3sEXBCaAeaOmSHp7RxdbjQveH7WCz0W6SjaloabTTlZkwEvsaeDjsMENb
	oO50CyBx8BEP4FrmnqSJyKGAvd/4G0MrRlmJnUFcEMQnKQFfRvqiNO03cH7P3jl96uBYz9kJtYc
	O1CjoGOfu3I5B4DZsnkEJxLFK1hJlvhtkCQPG/PZZ7Fwfp4lrDnsybdXXlBfXoV6kjeTTMya2PH
	dlWv3Vs/vyzl3RJFrE3Ib57VqogGTdyXtHrPyvDL3r9Qe9Rbob0vCS8hAp8hMvxSzVK8b9t/xvs
	A8tNQ8kTXKElrWO9PBMaAfx1TnLYLFctd+7pqgNb7LbawookFLagd6OuEr8YhxyTxmtr7TIcMjg
	AHodIqmUBuckqcxqlyZ9asJEVSgDa3EZ+eZMfMoEfjyZNLWlChsO7LC3J2Y+6t3XUi8uPr685WX
	3Y6Dn6opIHoVL8QMZXTWuqxdmz1ElTVFfZhb4xABCSflYaWzJ3COPqLWAcorRmWpjgpZveoqgro
	zjwimw+xwK8+J0hiIHLa2+IBTusng8H1KBGMsRZ1eMPXkM5wIziVsaYuglJo8N5Ktk=
X-Received: by 2002:a17:902:e88e:b0:2e6:3f5:8f2e with SMTP id d9443c01a7336-2e87bc1caecmr1258995ad.3.1791602864275;
        Fri, 09 Oct 2026 20:27:44 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab39238608sm6549877a91.17.2026.10.09.20.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:27:43 -0700 (PDT)
Date: Sat, 10 Oct 2026 03:27:39 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v5 06/18] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <asmupccDpWIFdQsG@google.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-7-skhawaja@google.com>
 <asW6q0UPBX+Y/YL0@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <asW6q0UPBX+Y/YL0@nvidia.com>

On Tue, Oct 06, 2026 at 08:21:15PM -0700, Nicolin Chen wrote:
>On Mon, Sep 21, 2026 at 12:48:22AM +0000, Samiullah Khawaja wrote:
>> @@ -827,6 +838,8 @@ struct iommu_domain_ops {
>>   * @singleton_group: Used internally for drivers that have only one group
>>   * @max_pasids: number of supported PASIDs
>>   * @ready: set once iommu_device_register() has completed successfully
>> + * @outgoing_preserved_state: preserved iommu state of outgoing kernel for
>> + * liveupdate.
>>   */
>>  struct iommu_device {
>>  	struct list_head list;
>> @@ -836,6 +849,10 @@ struct iommu_device {
>>  	struct iommu_group *singleton_group;
>>  	u32 max_pasids;
>>  	bool ready;
>> +
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	struct iommu_hw_ser *outgoing_preserved_state;
>> +#endif
>
>It'd be nicer to align the naming.
>
>There are:
>	struct iommu_hw_ser *outgoing_preserved_state;
>	..
>	struct iommu_device_ser *device_ser;
>	..
>	struct iommu_domain_ser *preserved_state
>
>Maybe use "_ser" for all?

That is a fair point. I will update this.
>
>>
>>  /**
>> @@ -890,6 +907,9 @@ struct dev_iommu {
>>  	u32				pci_32bit_workaround:1;
>>  	u32				require_direct:1;
>>  	u32				shadow_on_flush:1;
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	struct iommu_device_ser		*device_ser;
>> +#endif
>
>Missing its kdoc update.

Will update.
>
>
>> @@ -1206,6 +1226,28 @@ static inline void *dev_iommu_priv_get(struct device *dev)
>>
>>  void dev_iommu_priv_set(struct device *dev, void *priv);
>>
>> +/**
>> + * typedef iommu_dev_iter_fn - Callback for iterating IOMMU attached devices
>> + * @dev: Attached device
>> + * @iommu: IOMMU instance
>> + * @arg: Private argument passed to iterator
>> + *
>> + * Return: 0 on success, or negative error code.
>> + */
>> +typedef int (*iommu_dev_iter_fn)(struct device *dev,
>> +				 struct iommu_device *iommu, void *arg);
>> +
>> +/**
>> + * struct iommu_dev_iter - Iterator for devices attached to an IOMMU
>> + */
>> +struct iommu_dev_iter {
>> +	struct iommu_device *iommu;
>> +	iommu_dev_iter_fn fn;
>> +	void *arg;
>> +};
>> +
>> +int iommu_for_each_dev(struct iommu_dev_iter *iter);
>
>It isn't very necessarily to expose iommu_dev_iter.
>
>iommu_for_each_dev could be simpler:
>
>int iommu_for_each_dev(struct iommu_device *iommu, iommu_dev_iter_fn fn,
>		       void *arg);
>
>Also, arg seems unused?

Agreed. I will update it to this:

int iommu_for_each_dev(struct iommu_device *iommu, iommu_dev_iter_fn fn);
>
>Nicolin

Thanks,
Sami
