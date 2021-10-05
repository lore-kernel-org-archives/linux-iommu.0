Return-Path: <SRS0=ORUS=OZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71E7C433EF
	for <iommu@archiver.kernel.org>; Tue,  5 Oct 2021 17:00:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959FD611C5
	for <iommu@archiver.kernel.org>; Tue,  5 Oct 2021 17:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 959FD611C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4961540860;
	Tue,  5 Oct 2021 17:00:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1G0U4KmAbpdj; Tue,  5 Oct 2021 17:00:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1B6724057D;
	Tue,  5 Oct 2021 17:00:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC90AC0011;
	Tue,  5 Oct 2021 17:00:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 326B7C000D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 17:00:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 12D8B401F6
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 17:00:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ftVawyNcpSYc for <iommu@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 17:00:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D535040284
 for <iommu@lists.linux-foundation.org>; Tue,  5 Oct 2021 17:00:02 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 w6-20020a4aa446000000b002b5795cca03so6616903ool.6
 for <iommu@lists.linux-foundation.org>; Tue, 05 Oct 2021 10:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=DcyLwF4zH8J97zpkynsCYmFmCV6WVI4TTXZkDMBOtnY=;
 b=ikfc0vKFXbP7XSoq7rvoFQIdTaQyIR5vB/o3yZc9AuiSiGozChnEPrwW9AMlw5CSmE
 1KKcQKUoxp9ErPQAlRPBMw4bgiwGnI/fVRtCaxhFW+eWp2AFVUFylwsgFSIv4CKmXUoW
 VxdH2MwQpas5Y+Ebl9pYUac+t9I720vnZCXhovoAGYkYyTLK8P8PMMq/Pl0Bl8JD4zmK
 +fZRwM6keE3M21v1QD1pDRy+03kLWZDxQGVCQIkBQojTI5nx/iWwewL3abcc6Xu0bipc
 9BpmsUNtWxels676SA7QAz/Oklc6LtAPKimn8Y9XdpqvvYcAIRfh5sCAk49TMEQAIf0R
 RRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=DcyLwF4zH8J97zpkynsCYmFmCV6WVI4TTXZkDMBOtnY=;
 b=xHnWPU/ZiAJ7t8QWmsOvTQsUo1S36XhnSvvzsjaS8GxSHKQnDVUwLi3ST4zmYkiZuP
 tUMIT1hBkvYcLj4LNyHVL9nDfyBjR9M00H38qfMvNmBOWrNRMmuJFT1FYgeAwrUTZb2M
 OroiYg0uyRMWjPqCrmaPrlfxGvVqHpLEhZ6YpcHSUzyM47Q1CH0FSHi/GxWFKxLx5pZE
 xmCoNwPrYI2EoTKebbW+j19ArhY9ueaMuev1o1BD2ka52ISL4aA/no6ftKtESjCWI55s
 DOCi+DTXEAgRgIU0vptAxCGwAb/Ll3QE0jTKRt99Z7LfPgU3bWoCvxtbtpNVQRHGjjG/
 eMSA==
X-Gm-Message-State: AOAM530yUuVr91EQ31woP1MpLwzcXpBCgI9+uCTFWDL0yVsuq4vFWsaL
 EniiBDMj/za7YKkNVeWeHmWmodVYOO0CQBFWJ7g=
X-Google-Smtp-Source: ABdhPJwvj4f8rwQJUYfN/kdxeSj7EoRN+5D6fGKYNpGULSiHlIotDI2s/k1pIK+TIq/QCPRfI4Os/AWBxTMjrVU4R2c=
X-Received: by 2002:a05:6820:358:: with SMTP id
 m24mr14428902ooe.34.1633453201846; 
 Tue, 05 Oct 2021 10:00:01 -0700 (PDT)
MIME-Version: 1.0
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Tue, 5 Oct 2021 22:29:50 +0530
Message-ID: <CAHP4M8UD0HnGCrR=8YFTYSehd968w4bgi_R4F0gzOUCm1veHsQ@mail.gmail.com>
Subject: Fitment/Use of IOMMU in KVM world when using PCI-devices
To: kvm@vger.kernel.org, linux-pci@vger.kernel.org, 
 iommu@lists.linux-foundation.org
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

Hi All.

I have been learning about a lot of inter-related things, kindly
correct me if I am wrong anywhere.
Till now, following have been broad observations :

a)
If we have IOMMU disabled on the host, things work fine in general on
a guest. But we cannot a attach a pci-device (physically attached to
host) to a guest.

b)
If we have IOMMU enabled on the host, we can attach a pci-device
(physically attached to a host) to a guest.




Going through the literature on the internet, it looks that we have
two modes supported by KVM / QEMU :

1.
Conventional shadow-mapping, which works in the most general case, for
GVA => GPA => HVA => HPA translations.

2.
EPT/NPT shadow-mapping, which works only if hardware-virtualization is
supported. As usual, the main purpose is to setup GVA => GPA => HVA =>
HPA translations.


In all the literature that mentioned the above modes, there were roles
of software-assisted MMU page-tables (at host-OS / guest-OS / kvm /
qemu).
The only mention of the IOMMU was with regard to pci-devices, to
maintain security and not letting guest-OSes create havoc on a
pci-device.





So, is the role of IOMMU to provide security/containership only?
In other words, if security was not a concern, would it still have
been possible to attach pci-devices on the guest-devices without
needing to enable the iommu?


Will be grateful to get pointers.


Thanks and Regards,
Ajay
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
