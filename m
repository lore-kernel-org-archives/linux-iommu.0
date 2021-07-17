Return-Path: <SRS0=ss7l=MJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AB1C636C9
	for <iommu@archiver.kernel.org>; Sat, 17 Jul 2021 15:33:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D61B6109E
	for <iommu@archiver.kernel.org>; Sat, 17 Jul 2021 15:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D61B6109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AA376066D;
	Sat, 17 Jul 2021 15:33:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yQHodApqOO_3; Sat, 17 Jul 2021 15:33:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B19F2605AF;
	Sat, 17 Jul 2021 15:33:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CC34C001A;
	Sat, 17 Jul 2021 15:33:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9FD6C000E
 for <iommu@lists.linux-foundation.org>; Sat, 17 Jul 2021 15:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 90F5B415F9
 for <iommu@lists.linux-foundation.org>; Sat, 17 Jul 2021 15:33:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UAIaXC9OC5qh for <iommu@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 15:33:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AAB7E415EC
 for <iommu@lists.linux-foundation.org>; Sat, 17 Jul 2021 15:33:21 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id b2so2384825plx.1
 for <iommu@lists.linux-foundation.org>; Sat, 17 Jul 2021 08:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=qik3aghtysSWJaeH26T5weIAVYbNhbj4jSdp7L5MNLw=;
 b=fep95pfTQ2QvFnOB/K94cHLsdJpd0dkwFmn/lrIrG0JOcnzvIe4gf4eGh8X0+QJPKI
 luMruMwNn3DqXP2AFkWvJvNBv+S3843XBv/WT5kHRA1AJqzQqwv6VK3+DQiXUv3lgf1U
 IgoJFOSFlznKQuys+UKCynSfZ/ysa4oQQnuYQQ3y6VrnLvZP80l4724uiWuxgtk1/nXp
 B7N7VWujGWgTh+Ab6qmGyRYc7yK2e+0JNoZoN1I4f/mGmLkxNJMq6B8Ng7+GusvJ0+8x
 lkiADSiw+uj9KDKLx0HrFcLP1Dwe5SDjJD+KZU8BMEU7gY0tSjX+NZtpU3hDFvAaghjn
 55Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=qik3aghtysSWJaeH26T5weIAVYbNhbj4jSdp7L5MNLw=;
 b=kmKUCh5EdEM+Y1ARN+9mEd5i/XQ+M3SqRXspAAEjZl1lohNZVqfBRhDsoHW1613T3M
 O9n2n2q+HGujyQHXP1cEXtj6+RWIH4dDEc8OVweliF/8dH7LVGnQpDdNvbBgtiWk2brp
 DDc0lU2D5BpVRNfFjgd7jyhwJtauIwxpX8Qg29//0yfY6hIvdPT4ja1BnucuY0I6psv4
 +f37nfLu3+HcGp58F9/gYLa3Sr330pPmApKOB+Uz7uWlMH8701mOOYbaoe1aXw0jDZsz
 PltecygAEziOdqMyUGwHMR7OmFIFBsHLg2ErRdW1mK6M9JIcUUoKk1WIikO6TJoVc/KZ
 boyw==
X-Gm-Message-State: AOAM533dpiBmdrc4qALocO6tGy/UhuNtE13HCom9RiuSMQSW06DLQUJb
 uUZvF3Swqd6r+X/ID9TS7DdSaTnPdQa2QsR23MS//7sdIM+a1A==
X-Google-Smtp-Source: ABdhPJz6oe3cZtcusF7WyDHJ0aXkNut7tb3/Bc4sAl3NOdP5mscCzH7ArEVOviBxVaYRMYcR2CsfY6Ly2Ghd+H6U+h8=
X-Received: by 2002:a17:90b:3581:: with SMTP id
 mm1mr20464266pjb.98.1626536000726; 
 Sat, 17 Jul 2021 08:33:20 -0700 (PDT)
MIME-Version: 1.0
From: Thomas JOURDAN <thomas.jourdan@gmail.com>
Date: Sat, 17 Jul 2021 17:33:10 +0200
Message-ID: <CALcT7Ku3uyZb53UvKJ=6touvgqscQNDJAFH8fWim-W5neVyG9g@mail.gmail.com>
Subject: PCIe transfer issue with fsl_pamu
To: iommu@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============4821041772288058662=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============4821041772288058662==
Content-Type: multipart/alternative; boundary="00000000000089ab2805c7536cac"

--00000000000089ab2805c7536cac
Content-Type: text/plain; charset="UTF-8"

Hi

I am trying to run the radeon and/or amdgpu drm driver on Freescale
T2080RDB with an AMD e8860 GPU. I am using the linux-qoirq 5.10 kernel.

On modprobe, the driver tests the GPU ring command. It will fill a command
buffer in system memory, then the GPU fetches the buffer and executes it.
As a result a scratch register of the GPU is updated and the GPU increases
its read pointer into the ring.

Without fsl_pamu enabled, this test works fine without triggering any
access error, which indicates all translation addresses are set up properly
(outbound, inbound and law).

But with fsl_pamu enabled, this test fails. The command buffer isn't
executed, neither the scratch value nor the read pointer into the ring are
updated. Moreover, the fsl_pamu driver doesn't trigger any access error.

My guess is a cache coherency issue. The GPU doesn't fetch from
system memory the proper values hence nothing is executed. However it's
only a guess as I have no expertise on the PAMU setup for this processor.

Any suggestions?

Regards
Thomas

--00000000000089ab2805c7536cac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><div>I am trying to run the radeon and/or=
 amdgpu drm driver on Freescale T2080RDB with an AMD e8860 GPU. I am using =
the linux-qoirq=C2=A05.10 kernel.</div><div><br></div><div>On modprobe, the=
 driver tests the GPU ring command. It will fill a command buffer in system=
 memory, then the GPU fetches the buffer and executes it. As a result a scr=
atch register of the GPU is updated and the GPU increases its read pointer =
into the ring.</div><div><br></div><div>Without fsl_pamu enabled, this test=
 works fine without triggering any access error, which indicates all transl=
ation=C2=A0addresses=C2=A0are set up properly (outbound, inbound and law).<=
/div><div><br></div><div>But with fsl_pamu enabled, this test fails. The co=
mmand buffer isn&#39;t executed, neither the scratch value nor the read poi=
nter into the ring are updated. Moreover, the fsl_pamu driver doesn&#39;t t=
rigger any access error.</div><div><br></div><div>My guess is a cache coher=
ency issue. The GPU doesn&#39;t fetch from system=C2=A0memory the proper va=
lues hence nothing is executed. However it&#39;s only a guess as I have no =
expertise on the PAMU setup for this processor.</div><div><br></div><div>An=
y=C2=A0suggestions?</div><div><br></div><div>Regards</div><div>Thomas</div>=
</div>

--00000000000089ab2805c7536cac--

--===============4821041772288058662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4821041772288058662==--
