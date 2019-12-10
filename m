Return-Path: <SRS0=4E9V=2A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23DFC43603
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 05:18:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7456820663
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 05:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WB0a+etP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7456820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3D9A22041C;
	Tue, 10 Dec 2019 05:18:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vz0JyMiwcO+S; Tue, 10 Dec 2019 05:18:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1E2FE20474;
	Tue, 10 Dec 2019 05:18:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3804C1D7D;
	Tue, 10 Dec 2019 05:18:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD2D4C0881
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 05:18:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C135887DFF
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 05:18:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lJ6AIHAWUcsS for <iommu@lists.linux-foundation.org>;
 Tue, 10 Dec 2019 05:18:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EA36A87DA6
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 05:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575955116;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g9eZ8Y8iolEJe2BZ46TjQzu7+WohM2nrv85DWgfUE3A=;
 b=WB0a+etPXwMJFGD8G03ciidQBMhdSzYRwFAibW3PmJ3T2dqD9Nk6sg9ALs+h19tfN/Tnxx
 jXp5YRoc+TPrhMcYxqfB+UR0aqCZUHtow2X20/b1MfLdy0dHjZZ7XHHlRbg5nTz6uVAUHD
 F8uH+d0bCTtOVZeum3ob+I2WmD+MKfk=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-Z6pkvdFjPJGRwXKdTNC4Vg-1; Tue, 10 Dec 2019 00:18:34 -0500
Received: by mail-yb1-f200.google.com with SMTP id b5so4037822ybq.23
 for <iommu@lists.linux-foundation.org>; Mon, 09 Dec 2019 21:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to;
 bh=Z1Kl1NjSl3mdxWiXIkFUkGj6x+VJua+ByiEsL6Dn7JU=;
 b=RpB1gk5W3g0YJCS5jH6+Bna/nrz2su21Zexl+2OYFvZa8h4Ks8CCpWsbxsqF+K+hLJ
 57eke2uRejhSc7cl+peSkb2PSA15ikkaXZSMURqoNmcbG4n3mMj5U/MnU2zM2axAN0XD
 Vt1RW3+j9fJ3QlZI9obvxBciBDcS8/CYXi+85qTn0kRibMslkgBfih1Fc14OL3K5anLE
 XsDqpenUA+1R2XxXmx0J5EIFAUoPHSBrd1Q5Y+6gmWe70BD9iWxGgH4hWsJi8xkshiTS
 S3+r3aq9MPqmI9bwSokrlqywnwjv/tg+i2ZZcg0caqkh1ntijfmIHESAI34ClJBYjcvQ
 XWlQ==
X-Gm-Message-State: APjAAAXk8FZzoHigcrqnvk6ZnFplBD4+mIfE5iMmoNoBSocxAdozPlP8
 xdhOCSrEjXXAefJkJIJ9TaolhS6APW0V9Qrl6U0Sv0DF1eRDill8qhkYtwRrKngb5T/lcalybF3
 3FVuF1qN/Ol+Sb1OqwtaR48wKb2borg==
X-Received: by 2002:a25:2f83:: with SMTP id
 v125mr23742369ybv.239.1575955113908; 
 Mon, 09 Dec 2019 21:18:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBBLt86aCwhZllruJMgTLLvalRZi1G4CFIloIq2nS/wyPfTOkJhy+9HIF/2JJGN1JHsZfB9w==
X-Received: by 2002:a25:2f83:: with SMTP id
 v125mr23742353ybv.239.1575955113561; 
 Mon, 09 Dec 2019 21:18:33 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id g131sm992132ywb.35.2019.12.09.21.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 21:18:32 -0800 (PST)
Date: Mon, 9 Dec 2019 22:18:30 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
Message-ID: <20191210051830.n37dimvrrgtiuydk@cantor>
References: <20191205025320.oiulo3msfcggdlv5@cantor>
 <d5fbedce-7a06-79b4-75fa-0aa3cc3ef73b@linux.intel.com>
 <20191206072453.5jjwrjedqbjimx45@cantor>
 <0f82007e-9887-d6b2-08e5-9c430c920b36@linux.intel.com>
 <20191207022914.7uccwkmgadz4hvbf@cantor>
 <20191207024118.uwwzthqifh2dca5q@cantor>
 <7979b838-e2c5-4064-490c-8e0884909715@linux.intel.com>
 <20191210005234.kanygdcjgsgo7z6j@cantor>
 <77d3ca8e-cb8c-4392-fa99-c55daa263b8e@linux.intel.com>
 <20191210034753.wlmbqdvqpcnzfxyl@cantor>
MIME-Version: 1.0
In-Reply-To: <20191210034753.wlmbqdvqpcnzfxyl@cantor>
X-MC-Unique: Z6pkvdFjPJGRwXKdTNC4Vg-1
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
[snip]
>
>A call to iommu_map is failing.
>
>[   36.686881] pci 0000:01:00.2: iommu_group_add_device: calling iommu_group_create_direct_mappings
>[   36.689843] pci 0000:01:00.2: iommu_group_create_direct_mappings: iterating through mappings
>[   36.692757] pci 0000:01:00.2: iommu_group_create_direct_mappings: calling apply_resv_region
>[   36.695526] pci 0000:01:00.2: e_direct_mappings: entry type is direct
>[   37.198053] iommu: iommu_map: ops->map failed iova 0xbddde000 pa 0x00000000bddde000 pgsize 0x1000
>[   37.201357] pci 0000:01:00.2: iommu_group_create_direct_mappings: iommu_map failed
>[   37.203973] pci 0000:01:00.2: iommu_group_create_direct_mappings: leaving func
>[   37.206385] pci 0000:01:00.2: iommu_group_add_device: calling __iommu_attach_device
>[   37.208950] pci 0000:01:00.2: Adding to iommu group 25
>[   37.210660] pci 0000:01:00.2: DMAR: domain->type is dma
>

It bails at the dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN check
at the beginning of intel_iommu_map.  I will verify, but it looks like
that is getting set when intel_iommu_add_device is called for 01:00.1.
request_default_domain_for_dev for 01:00.1 will return -EBUSY because
iommu_group_device_count(group) != 1.

>Also fails for 01:00.4:
>
>[   37.212448] pci 0000:01:00.4: iommu_group_add_device: calling iommu_group_create_direct_mappings
>[   37.215382] pci 0000:01:00.4: iommu_group_create_direct_mappings: iterating through mappings
>[   37.218170] pci 0000:01:00.4: iommu_group_create_direct_mappings: calling apply_resv_region
>[   37.220933] pci 0000:01:00.4: iommu_group_create_direct_mappings: entry type is direct-relaxable
>[   37.223932] iommu: iommu_map: ops->map failed iova 0xbddde000 pa 0x00000000bddde000 pgsize 0x1000
>[   37.226857] pci 0000:01:00.4: iommu_group_create_direct_mappings: iommu_map failed
>[   37.229300] pci 0000:01:00.4: iommu_group_create_direct_mappings: leaving func
>[   37.231648] pci 0000:01:00.4: iommu_group_add_device: calling __iommu_attach_device
>[   37.234194] pci 0000:01:00.4: Adding to iommu group 25
>[   37.236192] pci 0000:01:00.4: DMAR: domain->type is dma
>[   37.237958] pci 0000:01:00.4: DMAR: device default domain type is identity. requesting identity domain
>[   37.241061] pci 0000:01:00.4: don't change mappings of existing d37.489870] pci 0000:01:00.4: DMAR: Device uses a private identity domain.
>
>There is an RMRR for 0xbddde000-0xddddefff:
>
>[63Ah 1594   2]                Subtable Type : 0001 [Reserved Memory Region]
>[63Ch 1596   2]                       Length : 0036
>
>[63Eh 1598   2]                     Reserved : 0000
>[640h 1600   2]           PCI Segment Number : 0000
>[642h 1602   8]                 Base Address : 00000000BDDDE000
>[64Ah 1610   8]          End Address (limit) : 00000000BDDDEFFF
>
>[652h 1618   1]            Device Scope Type : 01 [PCI Endpoint Device]
>[653h 1619   1]                 Entry Length : 0A
>[654h 1620   2]                     Reserved : 0000
>[656h 1622   1]               Enumeration ID : 00
>[657h 1623   1]               PCI Bus Number : 00
>
>[658h 1624   2]                     PCI Path : 1C,07
>
>[65Ah 1626   2]                     PCI Path : 00,00
>
>
>[65Ch 1628   1]            Device Scope Type : 01 [PCI Endpoint Device]
>[65Dh 1629   1]                 Entry Length : 0A
>[65Eh 1630   2]                     Reserved : 0000
>[660h 1632   1]               Enumeration ID : 00
>[661h 1633   1]               PCI Bus Number : 00
>
>[662h 1634   2]                     PCI Path : 1C,07
>
>[664h 1636   2]                     PCI Path : 00,02
>
>
>[666h 1638   1]            Device Scope Type : 01 [PCI Endpoint Device]
>[667h 1639   1]                 Entry Length : 0A
>[668h 1640   2]                     Reserved : 0000
>[66Ah 1642   1]               Enumeration ID : 00
>[66Bh 1643   1]               PCI Bus Number : 00
>
>[66Ch 1644   2]                     PCI Path : 1C,07
>
>[66Eh 1646   2]                     PCI Path : 00,04
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
