Return-Path: <SRS0=jQQH=32=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1D2C33CAC
	for <iommu@archiver.kernel.org>; Thu,  6 Feb 2020 17:54:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 459B4214AF
	for <iommu@archiver.kernel.org>; Thu,  6 Feb 2020 17:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3kYyb6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459B4214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DC2E183612;
	Thu,  6 Feb 2020 17:54:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BlLxlOz3XdHy; Thu,  6 Feb 2020 17:54:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4214B8354B;
	Thu,  6 Feb 2020 17:54:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20D95C1D81;
	Thu,  6 Feb 2020 17:54:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9288C013E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 17:54:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E214E87BEE
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 17:54:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lRGXPlOkM4GL for <iommu@lists.linux-foundation.org>;
 Thu,  6 Feb 2020 17:54:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1685887B9B
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 17:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581011677;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type; bh=KMaOT3D7GBO95SeGU8caYlLfuqZ+FgjEFWujbDAq6Gc=;
 b=G3kYyb6mwF6orOCMjMq+RWZt4rprCwdFRQ0tR3JHsDC4uf+ymkErtEjnvbmgXm3fyU2kbr
 An/fEVytA+OL/3o2vhQjZRFkyjiQErtcEHY07v0zgCKAMtql6x5C9N6WQzCFBruS9JBZLb
 r3t71u/FvYJuiSFbZ92fiJKpF37FJBw=
Received: from mail-yw1-f72.google.com (mail-yw1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-o3yxUUsDNHuoXn18L9DWfg-1; Thu, 06 Feb 2020 12:54:36 -0500
Received: by mail-yw1-f72.google.com with SMTP id l12so7921685ywk.6
 for <iommu@lists.linux-foundation.org>; Thu, 06 Feb 2020 09:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:reply-to
 :mime-version:content-disposition;
 bh=KMaOT3D7GBO95SeGU8caYlLfuqZ+FgjEFWujbDAq6Gc=;
 b=UO6HhQDbU5GMSSn0LIde1PSsl3wh9TjCKKBLMNqwagg/6R9CXCnsDsykT5uHs6kXth
 txK0Ge8fWKehipQmH6XicTSHjOqh013Muh+Ly1TpKYaYPHMajNOL35yySlpBwT8ZcDiw
 HxzdXw3WF7162o5BzT9OvYA0T2BU0fwzf7omh82DrrGJMpsqJ42ATKIRXvbnrQZipyZ/
 0czXaZgnWFIwjFW6MAXlTL5GuRg86DEDAf8Sgf5rnTIIBidMMvCk1KNJEZJtW2PDoi18
 8XPUlMhumTlbnVJO4c1fe1hdcmwwP3J6yj+poH7HHTEOB6k6sqc8VY3tLftfpB1HOcp7
 iS4g==
X-Gm-Message-State: APjAAAWoul0/cZA7fsJmsiNCkH4Iv9USrDQ0zoOvlOPzCteUaueaR4TM
 Hf3yAcZNz6aS6itr+KNvv7lxY8vWO2QRACcgrFApOupibYCLOu9mBkihvFCt1R1t5GK2x1x5d1W
 hlJNmChc1bzHA+Oosh2JHZUZBI9unnA==
X-Received: by 2002:a25:4088:: with SMTP id n130mr3997768yba.377.1581011675371; 
 Thu, 06 Feb 2020 09:54:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqwqtWXzA5HZditqNZSRO0xr9hRae1zFZfklcVzDid9SKvEIt7gmKZOWnCDAwJldu3EO+XcPKg==
X-Received: by 2002:a25:4088:: with SMTP id n130mr3997743yba.377.1581011675048; 
 Thu, 06 Feb 2020 09:54:35 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id d188sm76590ywd.24.2020.02.06.09.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:54:34 -0800 (PST)
Date: Thu, 6 Feb 2020 10:54:32 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux-foundation.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: Seeing some another issue with mixed domains in the same iommu_group
Message-ID: <20200206175432.4r5vaurm6codfa4a@cantor>
MIME-Version: 1.0
X-MC-Unique: o3yxUUsDNHuoXn18L9DWfg-1
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

Hi Baolu,

I'm seeing another issue with the devices in the HP ilo when the
system is booted with intel_iommu=on and iommu=pt (iommu=nopt does not
run into problems).

first system:

01:00.0 System peripheral: Hewlett-Packard Company Integrated Lights-Out Standard Slave Instrumentation & System Support (rev 05)
01:00.1 VGA compatible controller: Matrox Electronics Systems Ltd. MGA G200EH
01:00.2 System peripheral: Hewlett-Packard Company Integrated Lights-Out Standard Management Processor Support and Messaging (rev 05)
01:00.4 USB controller: Hewlett-Packard Company Integrated Lights-Out Standard Virtual USB Controller (rev 02)

[   21.208103] pci 0000:01:00.0: Adding to iommu group 24
[   21.210911] pci 0000:01:00.0: Using iommu dma mapping
[   21.212635] pci 0000:01:00.1: Adding to iommu group 24
[   21.214326] pci 0000:01:00.1: Device uses a private identity domain.
[   21.216507] pci 0000:01:00.2: Adding to iommu group 24
[   21.618173] pci 0000:01:00.4: Adding to iommu group 24
[   21.619839] pci 0000:01:00.4: Device uses a private identity domain.

[   26.206832] uhci_hcd: USB Universal Host Controller Interface driver
[   26.209044] uhci_hcd 0000:01:00.4: UHCI Host Controller
[   26.210897] uhci_hcd 0000:01:00.4: new USB bus registered, assigned bus number 3
[   26.213247] uhci_hcd 0000:01:00.4: detected 8 ports
[   26.214810] uhci_hcd 0000:01:00.4: port count misdetected? forcing to 2 ports
[   26.217153] uhci_hcd 0000:01:00.4: irq 16, io base 0x00003c00
[   26.219171] uhci_hcd 0000:01:00.4: 32bit DMA uses non-identity mapping
[   26.221261] uhci_hcd 0000:01:00.4: unable to allocate consistent memory for frame list
[   26.223787] uhci_hcd 0000:01:00.4: startup error -16
[   26.225381] uhci_hcd 0000:01:00.4: USB bus 3 deregistered
[   26.227378] uhci_hcd 0000:01:00.4: init 0000:01:00.4 fail, -16
[   26.229296] uhci_hcd: probe of 0000:01:00.4 failed with error -16


different system with similar issue:

01:00.0 System peripheral [0880]: Hewlett-Packard Company Integrated Lights-Out Standard Slave Instrumentation & System Support [103c:3306] (rev 07)
01:00.1 VGA compatible controller [0300]: Matrox Electronics Systems Ltd. MGA G200eH3 [102b:0538] (rev 02) (prog-if 00 [VGA controller])
01:00.2 System peripheral [0880]: Hewlett-Packard Company Integrated Lights-Out Standard Management Processor Support and Messaging [103c:3307] (rev 07)
01:00.4 USB controller [0c03]: Hewlett-Packard Company iLO5 Virtual USB Controller [103c:22f6] (prog-if 20 [EHCI])

[   13.695663] pci 0000:01:00.0: Adding to iommu group 10
[   13.703667] pci 0000:01:00.0: Using iommu dma mapping
[   13.708871] pci 0000:01:00.1: Adding to iommu group 10
[   13.714033] pci 0000:01:00.1: DMAR: Device uses a private identity domain.
[   13.721033] pci 0000:01:00.2: Adding to iommu group 10
[   13.726290] pci 0000:01:00.4: Adding to iommu group 10
[   13.731453] pci 0000:01:00.4: DMAR: Device uses a private identity domain.

[   17.157796] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   17.164348] ehci-pci: EHCI PCI platform driver
[   17.170061] ehci-pci 0000:01:00.4: EHCI Host Controller
[   17.175457] ehci-pci 0000:01:00.4: new USB bus registered, assigned bus number 1
[   17.182912] ehci-pci 0000:01:00.4: DMAR: 32bit DMA uses non-identity mapping
[   17.189988] ehci-pci 0000:01:00.4: can't setup: -12
[   17.194884] ehci-pci 0000:01:00.4: USB bus 1 deregistered
[   17.200567] ehci-pci 0000:01:00.4: init 0000:01:00.4 fail, -12
[   17.206508] ehci-pci: probe of 0000:01:00.4 failed with error -12


I'm looking through the code and trying to debug it, but any thoughts on this?

Regards,
Jerry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
