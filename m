Return-Path: <SRS0=jQQH=32=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902A8C35247
	for <iommu@archiver.kernel.org>; Thu,  6 Feb 2020 21:36:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F19021775
	for <iommu@archiver.kernel.org>; Thu,  6 Feb 2020 21:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXCdcx0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F19021775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1334786265;
	Thu,  6 Feb 2020 21:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Tc3XXc4KWXc; Thu,  6 Feb 2020 21:36:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7185786267;
	Thu,  6 Feb 2020 21:36:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54C67C1D81;
	Thu,  6 Feb 2020 21:36:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C627C013E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 21:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8AB1386BA8
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 21:36:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 20I8y1wgqYxb for <iommu@lists.linux-foundation.org>;
 Thu,  6 Feb 2020 21:36:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 54AFA86BAD
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 21:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581025008;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=0VFbP7BXaLfpce4kJZNCj8MfcQGgViR1mgcR/a1SkGU=;
 b=cXCdcx0z3OASv0Y2aAvmYUU8VfH1dJox0ajiATObP5exdGgOYADpZa6xn8+D8QCPReG7wT
 A6KJrbjJvIKBxKGnVlOyxYN0G0TDG1uOwYfsrsnFsANm3U+2AAW7FEtQsze71Cug6fjiJd
 8H0pAJAS0JSX+ZjLIgutfQdXS6ze6lg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-LFkFYgSWOUOXnHEnTUgDfQ-1; Thu, 06 Feb 2020 16:36:46 -0500
Received: by mail-yb1-f199.google.com with SMTP id t3so319811ybb.5
 for <iommu@lists.linux-foundation.org>; Thu, 06 Feb 2020 13:36:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to;
 bh=0VFbP7BXaLfpce4kJZNCj8MfcQGgViR1mgcR/a1SkGU=;
 b=LaaXuGthAfrNxERLqS+4IzluesUaK7fYKjmTx4+snof3FUniWtQu2D+PSbus5sDrVG
 fDtPZ7xUrBBzCeNz0RH+mV+WjWFT0CnVqJ61PsbkYkSf47lJ9qpZk5Y8hnXm1p7mHZuJ
 k66dItR+W04fHhs+Fevh92vrjTVUw1ljr72d09iD11RYyTqzn57WrIYWtAH2XxCyYIHl
 FrxGjUDmSpOT/uhrSBk31JQcGHIkeRerQ/0+NtXUNP/qMBCx2mcjO/rgOz4vnfaML1T2
 N4Ls7WB7NlH1W6esaHVRou9GkZijpC4rxiscHnxdwPqeFoK1NCoeyJ0DDV6tkDEnZNu1
 UuYA==
X-Gm-Message-State: APjAAAVMVflAzx9EMU+OerhScngcGErUf6b+YGU/5JkrsZI8nbgGdnib
 gBWCbhp3G8AXu4ICcC8gbGooeKL1Y6HPAtU+5CgEEOAlzFBQ32ja+7amIkD4yhTP1ITjF5uWb3Q
 13fF2i6J+JlWuy7D29eoi++nDR+pHaw==
X-Received: by 2002:a81:6956:: with SMTP id e83mr4859127ywc.331.1581025005581; 
 Thu, 06 Feb 2020 13:36:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqxSRXOIhUoYfoRMgqljXnin4UtAyDRUXiFnAWOEUVgKnLbdFU0Q/LMmPzxFoq2tW7st0/Y5yQ==
X-Received: by 2002:a81:6956:: with SMTP id e83mr4859115ywc.331.1581025005151; 
 Thu, 06 Feb 2020 13:36:45 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id q62sm329223ywg.76.2020.02.06.13.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 13:36:44 -0800 (PST)
Date: Thu, 6 Feb 2020 14:36:43 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux-foundation.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: Seeing some another issue with mixed domains in the same
 iommu_group
Message-ID: <20200206213643.b75uilwh3m76rprx@cantor>
References: <20200206175432.4r5vaurm6codfa4a@cantor>
 <20200206184707.h3lfh2qaxaooe2vi@cantor>
MIME-Version: 1.0
In-Reply-To: <20200206184707.h3lfh2qaxaooe2vi@cantor>
X-MC-Unique: LFkFYgSWOUOXnHEnTUgDfQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Thu Feb 06 20, Jerry Snitselaar wrote:
>On Thu Feb 06 20, Jerry Snitselaar wrote:
>>Hi Baolu,
>>
>>I'm seeing another issue with the devices in the HP ilo when the
>>system is booted with intel_iommu=on and iommu=pt (iommu=nopt does not
>>run into problems).
>>
>>first system:
>>
>>01:00.0 System peripheral: Hewlett-Packard Company Integrated Lights-Out Standard Slave Instrumentation & System Support (rev 05)
>>01:00.1 VGA compatible controller: Matrox Electronics Systems Ltd. MGA G200EH
>>01:00.2 System peripheral: Hewlett-Packard Company Integrated Lights-Out Standard Management Processor Support and Messaging (rev 05)
>>01:00.4 USB controller: Hewlett-Packard Company Integrated Lights-Out Standard Virtual USB Controller (rev 02)
>>
>>[   21.208103] pci 0000:01:00.0: Adding to iommu group 24
>>[   21.210911] pci 0000:01:00.0: Using iommu dma mapping
>>[   21.212635] pci 0000:01:00.1: Adding to iommu group 24
>>[   21.214326] pci 0000:01:00.1: Device uses a private identity domain.
>>[   21.216507] pci 0000:01:00.2: Adding to iommu group 24
>>[   21.618173] pci 0000:01:00.4: Adding to iommu group 24
>>[   21.619839] pci 0000:01:00.4: Device uses a private identity domain.
>>
>>[   26.206832] uhci_hcd: USB Universal Host Controller Interface driver
>>[   26.209044] uhci_hcd 0000:01:00.4: UHCI Host Controller
>>[   26.210897] uhci_hcd 0000:01:00.4: new USB bus registered, assigned bus number 3
>>[   26.213247] uhci_hcd 0000:01:00.4: detected 8 ports
>>[   26.214810] uhci_hcd 0000:01:00.4: port count misdetected? forcing to 2 ports
>>[   26.217153] uhci_hcd 0000:01:00.4: irq 16, io base 0x00003c00
>>[   26.219171] uhci_hcd 0000:01:00.4: 32bit DMA uses non-identity mapping
>>[   26.221261] uhci_hcd 0000:01:00.4: unable to allocate consistent memory for frame list
>>[   26.223787] uhci_hcd 0000:01:00.4: startup error -16
>>[   26.225381] uhci_hcd 0000:01:00.4: USB bus 3 deregistered
>>[   26.227378] uhci_hcd 0000:01:00.4: init 0000:01:00.4 fail, -16
>>[   26.229296] uhci_hcd: probe of 0000:01:00.4 failed with error -16
>>
>>
>>different system with similar issue:
>>
>>01:00.0 System peripheral [0880]: Hewlett-Packard Company Integrated Lights-Out Standard Slave Instrumentation & System Support [103c:3306] (rev 07)
>>01:00.1 VGA compatible controller [0300]: Matrox Electronics Systems Ltd. MGA G200eH3 [102b:0538] (rev 02) (prog-if 00 [VGA controller])
>>01:00.2 System peripheral [0880]: Hewlett-Packard Company Integrated Lights-Out Standard Management Processor Support and Messaging [103c:3307] (rev 07)
>>01:00.4 USB controller [0c03]: Hewlett-Packard Company iLO5 Virtual USB Controller [103c:22f6] (prog-if 20 [EHCI])
>>
>>[   13.695663] pci 0000:01:00.0: Adding to iommu group 10
>>[   13.703667] pci 0000:01:00.0: Using iommu dma mapping
>>[   13.708871] pci 0000:01:00.1: Adding to iommu group 10
>>[   13.714033] pci 0000:01:00.1: DMAR: Device uses a private identity domain.
>>[   13.721033] pci 0000:01:00.2: Adding to iommu group 10
>>[   13.726290] pci 0000:01:00.4: Adding to iommu group 10
>>[   13.731453] pci 0000:01:00.4: DMAR: Device uses a private identity domain.
>>
>>[   17.157796] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>>[   17.164348] ehci-pci: EHCI PCI platform driver
>>[   17.170061] ehci-pci 0000:01:00.4: EHCI Host Controller
>>[   17.175457] ehci-pci 0000:01:00.4: new USB bus registered, assigned bus number 1
>>[   17.182912] ehci-pci 0000:01:00.4: DMAR: 32bit DMA uses non-identity mapping
>>[   17.189988] ehci-pci 0000:01:00.4: can't setup: -12
>>[   17.194884] ehci-pci 0000:01:00.4: USB bus 1 deregistered
>>[   17.200567] ehci-pci 0000:01:00.4: init 0000:01:00.4 fail, -12
>>[   17.206508] ehci-pci: probe of 0000:01:00.4 failed with error -12
>>
>>
>>I'm looking through the code and trying to debug it, but any thoughts on this?
>>
>>Regards,
>>Jerry
>
>In iommu_need_mapping, in a case like the above does something like dmar_insert_one_dev_info need to
>happen to associate the device back with the group default domain? In intel_iommu_add_device it is
>going to get removed and added to the identity domain, and then in iommu_need_mapping it gets removed
>from the identity domain, and iommu_request_dma_domain_for_dev should return 0 because the group
>default domain at this point is the correct type.

The above cases seem to be avoided by:

9235cb13d7d1 | 2020-01-24 | iommu/vt-d: Allow devices with RMRRs to use identity domain (Lu Baolu)

which results in the watchdog device no longer taking a dma domain and switching the group default.


Without that patch though when it gets into the iommu_need_mapping code for 0000:01:00.4 after
the following:

		dmar_remove_one_dev_info(dev);
		ret = iommu_request_dma_domain_for_dev(dev);

ret is 0 and dev->archdata.iommu is NULL. Even with 9235cb13d7d1 device_def_domain_type can return
return dma, but I'm not sure how likely it is for there to be an iommu group like that again where
the group default ends up dma, a device gets removed and added to the identity domain, and then
ends up in that code in iommu_need_mapping.


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
