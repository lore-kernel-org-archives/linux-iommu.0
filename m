Return-Path: <SRS0=4E9V=2A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0C2C43603
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 05:44:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2399206D5
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 05:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZElSdrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2399206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9FF7487942;
	Tue, 10 Dec 2019 05:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sNwRv-39NXtV; Tue, 10 Dec 2019 05:44:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 141E6878C0;
	Tue, 10 Dec 2019 05:44:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F292EC1D7D;
	Tue, 10 Dec 2019 05:43:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FDF5C0881
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 05:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0C57187CD4
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 05:43:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DXFQ0t39lSFh for <iommu@lists.linux-foundation.org>;
 Tue, 10 Dec 2019 05:43:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A172787E14
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 05:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575956636;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5GPSCCUQmO/ymoCnVsz0apml2hzjJ/EvD2DrHZYhg38=;
 b=DZElSdrj2M6vDp2LoBJAWFUfYxXcy2MmEVhwCiF2rZzt0cAzRONBu8kQC645aUVknRrgPu
 EH1erlJX5HTlpTYVnRfU8E+Y5Zl5+dGzf1moXupZfUbp9rTRZ1GCBadOFT4Xo41SOYw2es
 B3BCXkExXYqVXbW/J9pEWJqhNRa/Bkg=
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-8Z5dkVnkOKK-Ecf7xy-rxw-1; Tue, 10 Dec 2019 00:43:54 -0500
Received: by mail-yw1-f71.google.com with SMTP id c68so13599591ywa.2
 for <iommu@lists.linux-foundation.org>; Mon, 09 Dec 2019 21:43:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to;
 bh=LNBKSn2aD+RGZLcyApF9HJ/HfIOziKUxmJUz4W8eS1Q=;
 b=oOZz1+Rzj2ixRLLzIfIoGXzpwzzqiwE/mfrJtPf/JSj+XRekV9DBCHcCM0bTS5WH8V
 kgws/Y8+DHVmUdenOE5hMAC/Hw4y6D/GD0ZNnjzl/bhlo8zpCcDRwZZIRF9rdIZxz8Po
 ENIqxc8PASbv7XY4W8UxPrkK1QSF0OQpmoBxdPROWhoxzijGPpWmJ6B5qeyL6XNRqvs2
 nUCv36kFtHVEFq+qrIYhy9gxH+B+a8CrMUb07A/VOcdVma2lXpMj/893At2DA7q/Bbs5
 lf4/8Qxy77drobb7JCCcfAPv8N/dIIKyox8Y49dyIlPGITc2yfqH6ISgJXmkG67O9vrD
 +LVQ==
X-Gm-Message-State: APjAAAXBmA3jGMZIfSBxadmWhfeKtAPWfDnRiMDFvZj13DpA+JFTDX3l
 wHcGVj6d1b3OwUaWx13ED6JwNiRrykmdomQkL8Ifvyu5PykhZvxI8d254PvfNPVPF00K8SC9lgs
 LAu8OTabr0QZN1o/WS54dqAMczh876Q==
X-Received: by 2002:a25:8288:: with SMTP id r8mr21733413ybk.24.1575956633963; 
 Mon, 09 Dec 2019 21:43:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqyH2vJLk7U3mp2nIUEWAZteoeJNnbxJoMyK5ojvOB4Exe/06qe3djlnXGohmiTDDLnMvt9YmA==
X-Received: by 2002:a25:8288:: with SMTP id r8mr21733403ybk.24.1575956633617; 
 Mon, 09 Dec 2019 21:43:53 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id w194sm1027923ywa.10.2019.12.09.21.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 21:43:52 -0800 (PST)
Date: Mon, 9 Dec 2019 22:43:51 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
Message-ID: <20191210054351.bswavli2z77zljvp@cantor>
References: <d5fbedce-7a06-79b4-75fa-0aa3cc3ef73b@linux.intel.com>
 <20191206072453.5jjwrjedqbjimx45@cantor>
 <0f82007e-9887-d6b2-08e5-9c430c920b36@linux.intel.com>
 <20191207022914.7uccwkmgadz4hvbf@cantor>
 <20191207024118.uwwzthqifh2dca5q@cantor>
 <7979b838-e2c5-4064-490c-8e0884909715@linux.intel.com>
 <20191210005234.kanygdcjgsgo7z6j@cantor>
 <77d3ca8e-cb8c-4392-fa99-c55daa263b8e@linux.intel.com>
 <20191210034753.wlmbqdvqpcnzfxyl@cantor>
 <20191210051830.n37dimvrrgtiuydk@cantor>
MIME-Version: 1.0
In-Reply-To: <20191210051830.n37dimvrrgtiuydk@cantor>
X-MC-Unique: 8Z5dkVnkOKK-Ecf7xy-rxw-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon Dec 09 19, Jerry Snitselaar wrote:
>On Mon Dec 09 19, Jerry Snitselaar wrote:
>[snip]
>>
>>A call to iommu_map is failing.
>>
>>[   36.686881] pci 0000:01:00.2: iommu_group_add_device: calling iommu_group_create_direct_mappings
>>[   36.689843] pci 0000:01:00.2: iommu_group_create_direct_mappings: iterating through mappings
>>[   36.692757] pci 0000:01:00.2: iommu_group_create_direct_mappings: calling apply_resv_region
>>[   36.695526] pci 0000:01:00.2: e_direct_mappings: entry type is direct
>>[   37.198053] iommu: iommu_map: ops->map failed iova 0xbddde000 pa 0x00000000bddde000 pgsize 0x1000
>>[   37.201357] pci 0000:01:00.2: iommu_group_create_direct_mappings: iommu_map failed
>>[   37.203973] pci 0000:01:00.2: iommu_group_create_direct_mappings: leaving func
>>[   37.206385] pci 0000:01:00.2: iommu_group_add_device: calling __iommu_attach_device
>>[   37.208950] pci 0000:01:00.2: Adding to iommu group 25
>>[   37.210660] pci 0000:01:00.2: DMAR: domain->type is dma
>>
>
>It bails at the dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN check
>at the beginning of intel_iommu_map.  I will verify, but it looks like
>that is getting set when intel_iommu_add_device is called for 01:00.1.
>request_default_domain_for_dev for 01:00.1 will return -EBUSY because
>iommu_group_device_count(group) != 1.
>

Also I see 01:00.0 and others that are the first in a group exiting iommu_group_create_direct_mappings
at the (!domain || domain->type != IOMMU_DOMAIN_DMA) check. In request_default_domain_for_dev default_domain
doesn't getting set until after that call. Should the iommu_group_create_direct_mappings call be moved below
where group->default_domain gets set?

>>Also fails for 01:00.4:
>>
>>[   37.212448] pci 0000:01:00.4: iommu_group_add_device: calling iommu_group_create_direct_mappings
>>[   37.215382] pci 0000:01:00.4: iommu_group_create_direct_mappings: iterating through mappings
>>[   37.218170] pci 0000:01:00.4: iommu_group_create_direct_mappings: calling apply_resv_region
>>[   37.220933] pci 0000:01:00.4: iommu_group_create_direct_mappings: entry type is direct-relaxable
>>[   37.223932] iommu: iommu_map: ops->map failed iova 0xbddde000 pa 0x00000000bddde000 pgsize 0x1000
>>[   37.226857] pci 0000:01:00.4: iommu_group_create_direct_mappings: iommu_map failed
>>[   37.229300] pci 0000:01:00.4: iommu_group_create_direct_mappings: leaving func
>>[   37.231648] pci 0000:01:00.4: iommu_group_add_device: calling __iommu_attach_device
>>[   37.234194] pci 0000:01:00.4: Adding to iommu group 25
>>[   37.236192] pci 0000:01:00.4: DMAR: domain->type is dma
>>[   37.237958] pci 0000:01:00.4: DMAR: device default domain type is identity. requesting identity domain
>>[   37.241061] pci 0000:01:00.4: don't change mappings of existing d37.489870] pci 0000:01:00.4: DMAR: Device uses a private identity domain.
>>
>>There is an RMRR for 0xbddde000-0xddddefff:
>>
>>[63Ah 1594   2]                Subtable Type : 0001 [Reserved Memory Region]
>>[63Ch 1596   2]                       Length : 0036
>>
>>[63Eh 1598   2]                     Reserved : 0000
>>[640h 1600   2]           PCI Segment Number : 0000
>>[642h 1602   8]                 Base Address : 00000000BDDDE000
>>[64Ah 1610   8]          End Address (limit) : 00000000BDDDEFFF
>>
>>[652h 1618   1]            Device Scope Type : 01 [PCI Endpoint Device]
>>[653h 1619   1]                 Entry Length : 0A
>>[654h 1620   2]                     Reserved : 0000
>>[656h 1622   1]               Enumeration ID : 00
>>[657h 1623   1]               PCI Bus Number : 00
>>
>>[658h 1624   2]                     PCI Path : 1C,07
>>
>>[65Ah 1626   2]                     PCI Path : 00,00
>>
>>
>>[65Ch 1628   1]            Device Scope Type : 01 [PCI Endpoint Device]
>>[65Dh 1629   1]                 Entry Length : 0A
>>[65Eh 1630   2]                     Reserved : 0000
>>[660h 1632   1]               Enumeration ID : 00
>>[661h 1633   1]               PCI Bus Number : 00
>>
>>[662h 1634   2]                     PCI Path : 1C,07
>>
>>[664h 1636   2]                     PCI Path : 00,02
>>
>>
>>[666h 1638   1]            Device Scope Type : 01 [PCI Endpoint Device]
>>[667h 1639   1]                 Entry Length : 0A
>>[668h 1640   2]                     Reserved : 0000
>>[66Ah 1642   1]               Enumeration ID : 00
>>[66Bh 1643   1]               PCI Bus Number : 00
>>
>>[66Ch 1644   2]                     PCI Path : 1C,07
>>
>>[66Eh 1646   2]                     PCI Path : 00,04
>>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
