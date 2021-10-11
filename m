Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADF3C433F5
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 06:19:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6AE60F6E
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 06:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ED6AE60F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD31D60715;
	Mon, 11 Oct 2021 06:19:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DzvVv4CTJaPD; Mon, 11 Oct 2021 06:19:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B3175606ED;
	Mon, 11 Oct 2021 06:19:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BC42C000F;
	Mon, 11 Oct 2021 06:19:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 077F0C000D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 06:19:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D084680F75
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 06:19:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gEdw_XaHXzBX for <iommu@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 06:19:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C98080F15
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 06:19:46 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id g125so16564933oif.9
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 23:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NQrmWWl63A33R8Wd94dEHY3g+CGyCI+tb3fF7nKj8Tk=;
 b=Qr6rXhVxFmYhsK8m4vTD/HFq5b9rd47q4NAYOYhjdVQNA8cQrFbwvZp3iL3nB7Brir
 4fx5ahVzODwaRFvhWN0Nl5VnyQ+5/W16F98AdIFeCrSyPX+6/MosKvLbRaDFVAhPEKsm
 tjtUheEKRh7wNasOZIMdAhpkBjsaGmyOW8nrm7BMFd+1awDUYWD97reFJ8UrV15rd+E8
 j4Owtm7OF/39OTog+A+t2JruMREZSDTRJ7qhPgaY60yjXFcOJMZdC+OboDtlyXLBfI67
 aure4EGxvPLok7eHkLVaA1M1J0Dai7Y8hLzUspPsYKUnQszLklVDipUNuIlyEHZWCMA2
 5X1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NQrmWWl63A33R8Wd94dEHY3g+CGyCI+tb3fF7nKj8Tk=;
 b=pHf6Ib9BOyqr+o14pvqPUbEt+wd7fkWCd4HifuTCUMSyhlF32d9Scr+AfaURWoMPN9
 6aMwBKNShHReC/f1jjMcoG+345fCuFN54j5M7zzmmhnHlTaSw6mXAUHZIViDdJJvDNTA
 wtcpc7JWLgDrlDem5d1aZNCHaXVdlD6co5suzC+IdrElrUCmZ7zqPrOD02Yn9ycG/BNB
 qn3kZP//9LLuKqwuZKvXNWEdWcuOh/Vc7vCE2PBNfENU9i5kYh3dXBmGR1lD26YpkNSu
 SI8iOBMmf94O/7318cqhGE0DgYjXq6Kmd5TnRi7l5OgSNUSXshtiwlrhxzou8rfpkYr+
 u5og==
X-Gm-Message-State: AOAM533zgXLEom2b9r1wI0RUGxsV83hw85AtJTgbUx2aeuoHGoKKiqYH
 0lSCAPglMh0BCVCVMhS31VxPJeHiL9D7yEeADkg=
X-Google-Smtp-Source: ABdhPJwpC0UYINOki3htK4lif6uPz1mOCm8+UV47WtM2pOR+74uBDeBfpzt/VFYoVXyDSYXd6Us5FtsJmWt3/Ym5bxU=
X-Received: by 2002:a05:6808:1211:: with SMTP id
 a17mr16766331oil.91.1633933185323; 
 Sun, 10 Oct 2021 23:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211002124012.18186-1-ajaygargnsit@gmail.com>
 <b9afdade-b121-cc9e-ce85-6e4ff3724ed9@linux.intel.com>
 <CAHP4M8Us753hAeoXL7E-4d29rD9+FzUwAqU6gKNmgd8G0CaQQw@mail.gmail.com>
 <20211004163146.6b34936b.alex.williamson@redhat.com>
 <CAHP4M8UeGRSqHBV+wDPZ=TMYzio0wYzHPzq2Y+JCY0uzZgBkmA@mail.gmail.com>
 <CAHP4M8UD-k76cg0JmeZAwaWh1deSP82RCE=VC1zHQEYQmX6N9A@mail.gmail.com>
In-Reply-To: <CAHP4M8UD-k76cg0JmeZAwaWh1deSP82RCE=VC1zHQEYQmX6N9A@mail.gmail.com>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Mon, 11 Oct 2021 11:49:33 +0530
Message-ID: <CAHP4M8VPem7xEtx3vQPm3bzCQif7JZFiXgiUGZVErTt5vhOF8A@mail.gmail.com>
Subject: Re: [PATCH] iommu: intel: remove flooding of non-error logs, when
 new-DMA-PTE is the same as old-DMA-PTE.
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org
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

The flooding was seen today again, after I booted the host-machine in
the morning.
Need to look what the heck is going on ...

On Sun, Oct 10, 2021 at 11:45 AM Ajay Garg <ajaygargnsit@gmail.com> wrote:
>
> > I'll try and backtrack to the userspace process that is sending these ioctls.
> >
>
> The userspace process is qemu.
>
> I compiled qemu from latest source, installed via "sudo make install"
> on host-machine, rebooted the host-machine, and booted up the
> guest-machine on the host-machine. Now, no kernel-flooding is seen on
> the host-machine.
>
> For me, the issue is thus closed-invalid; admins may take the
> necessary action to officially mark ;)
>
>
> Thanks and Regards,
> Ajay
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
