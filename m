Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FAFC4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 10:04:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A135160F25
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 10:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A135160F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 62FF1401B0;
	Tue, 10 Aug 2021 10:04:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bmoRcg4OFbpU; Tue, 10 Aug 2021 10:04:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DB437400EC;
	Tue, 10 Aug 2021 10:04:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E215C001A;
	Tue, 10 Aug 2021 10:04:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 153D5C000E;
 Tue, 10 Aug 2021 10:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E542681CA7;
 Tue, 10 Aug 2021 10:04:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wM6BH4kJbSSX; Tue, 10 Aug 2021 10:04:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D16081B17;
 Tue, 10 Aug 2021 10:04:24 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 m36-20020a05600c3b24b02902e67543e17aso1506861wms.0; 
 Tue, 10 Aug 2021 03:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nNPyEQUv6Ji6aWmVMQgSNl5jQ96sNm9i4LSvAWR0eaA=;
 b=q2gbUw9U5RtXDLYisdSeQSgCrPFXvSu38/Nc8e2OtpE6cCuDTC/Rup5pd6D7I3GphR
 wr7FNqUbH0b/vddvNEjoyl/Iu1esfKxdseTtw3MrVUENz/DZBisiwI6dbSE3CSAtwEDG
 jPEyDtmp9zi0ZY38Dj+7BCNz5TAysF3z0XOnCSsIEKP73HSZq5LNvW3Ui0dyLUYYtCji
 loJD6PFV16PJdB4607ccaCuBgzDpAdxi/tlXQofuQf2CZktqhSp38YBqiOCZ/B6AjLtp
 cyczg3ABjA43CEQFbUA3Nrsh5tchELIl3wkx86Kf8Chox7fLdzZiPOjXw77Ijj1ExgVk
 nGwQ==
X-Gm-Message-State: AOAM530qp5gTvBfBtwnflrBxxsjdgQ2YLQRR0fFcbm5DyfXfF9rBUasB
 c2+vibIoO0nqb9z6cKPNlUo=
X-Google-Smtp-Source: ABdhPJxqwuyMnHbZRg1qBZctOdB5h6Kf4V8NZCJ8ord6bBrxy7xEi7XisJdq+Xmsrl1aGAMEv6+vWg==
X-Received: by 2002:a05:600c:1c11:: with SMTP id
 j17mr21277438wms.35.1628589862198; 
 Tue, 10 Aug 2021 03:04:22 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id e3sm9074443wro.15.2021.08.10.03.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Aug 2021 03:04:21 -0700 (PDT)
Date: Tue, 10 Aug 2021 10:04:19 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [RFC v1 6/8] mshv: command line option to skip devices in PV-IOMMU
Message-ID: <20210810100419.g3rjj3xegydalyz3@liuwe-devbox-debian-v2>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-7-wei.liu@kernel.org>
 <4a6918ea-e3e5-55c9-a12d-bee7261301fd@linux.microsoft.com>
 <20210803215617.fzx2vrzhsabrrolc@liuwe-devbox-debian-v2>
 <8d9b6b9a-62b1-95ea-1bb6-258e72c1800d@linux.microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8d9b6b9a-62b1-95ea-1bb6-258e72c1800d@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, pasha.tatashin@soleen.com,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Aug 04, 2021 at 12:33:54PM +0530, Praveen Kumar wrote:
> On 04-08-2021 03:26, Wei Liu wrote:
> >>>  	struct iommu_domain domain;
> >>> @@ -774,6 +784,41 @@ static struct iommu_device *hv_iommu_probe_device(struct device *dev)
> >>>  	if (!dev_is_pci(dev))
> >>>  		return ERR_PTR(-ENODEV);
> >>>  
> >>> +	/*
> >>> +	 * Skip the PCI device specified in `pci_devs_to_skip`. This is a
> >>> +	 * temporary solution until we figure out a way to extract information
> >>> +	 * from the hypervisor what devices it is already using.
> >>> +	 */
> >>> +	if (pci_devs_to_skip && *pci_devs_to_skip) {
> >>> +		int pos = 0;
> >>> +		int parsed;
> >>> +		int segment, bus, slot, func;
> >>> +		struct pci_dev *pdev = to_pci_dev(dev);
> >>> +
> >>> +		do {
> >>> +			parsed = 0;
> >>> +
> >>> +			sscanf(pci_devs_to_skip + pos,
> >>> +				" (%x:%x:%x.%x) %n",
> >>> +				&segment, &bus, &slot, &func, &parsed);
> >>> +
> >>> +			if (parsed <= 0)
> >>> +				break;
> >>> +
> >>> +			if (pci_domain_nr(pdev->bus) == segment &&
> >>> +				pdev->bus->number == bus &&
> >>> +				PCI_SLOT(pdev->devfn) == slot &&
> >>> +				PCI_FUNC(pdev->devfn) == func)
> >>> +			{
> >>> +				dev_info(dev, "skipped by MSHV IOMMU\n");
> >>> +				return ERR_PTR(-ENODEV);
> >>> +			}
> >>> +
> >>> +			pos += parsed;
> >>> +
> >>> +		} while (pci_devs_to_skip[pos]);
> >>
> >> Is there a possibility of pci_devs_to_skip + pos > sizeof(pci_devs_to_skip)
> >> and also a valid memory ?
> > 
> > pos should point to the last parsed position. If parsing fails pos does
> > not get updated and the code breaks out of the loop. If parsing is
> > success pos should point to either the start of next element of '\0'
> > (end of string). To me this is good enough.
> 
> The point is, hypothetically the address to pci_devs_to_skip + pos can
> be valid address (later to '\0'), and thus there is a possibility,
> that parsing may not fail.

Have you found an example how at any given point in time
pci_devs_to_skip + pos can point outside of user provided string?

> Another, there is also a possibility of sscanf faulting accessing the
> illegal address, if pci_devs_to_skip[pos] turns out to be not NULL or
> valid address.

That depends on pci_devs_to_skip + pos can point to an invalid address
in the first place, so that goes back to the question above.

> 
> > 
> >> I would recommend to have a check of size as well before accessing the
> >> array content, just to be safer accessing any memory.
> >>
> > 
> > What check do you have in mind?
> 
> Something like,
> size_t len = strlen(pci_devs_to_skip);
> do {
> 
> 	len -= parsed;
> } while (len);
> 
> OR
> 
> do {
> ...
> 	pos += parsed;
> } while (pos < len);
> 
> Further, I'm also fine with the existing code, if you think this won't
> break and already been taken care. Thanks.

But in the loop somewhere you will still need to parse pci_devs_to_skip
+ some_offset. The new code structure does not remove that, right?

Given this is for debugging and is supposed to be temporary, I think the
code is good enough. But I want to make sure if there is anything I
missed.

Wei.

> 
> Regards,
> 
> ~Praveen.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
