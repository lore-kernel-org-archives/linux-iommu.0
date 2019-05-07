Return-Path: <SRS0=4fho=TH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA53C004C9
	for <iommu@archiver.kernel.org>; Tue,  7 May 2019 18:05:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D044B206BF
	for <iommu@archiver.kernel.org>; Tue,  7 May 2019 18:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="CKfT17s5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D044B206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 738CAC6A;
	Tue,  7 May 2019 18:05:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 57268A55
	for <iommu@lists.linux-foundation.org>;
	Tue,  7 May 2019 18:05:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
	[209.85.208.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 741CE7DB
	for <iommu@lists.linux-foundation.org>;
	Tue,  7 May 2019 18:05:35 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id u21so6032859lja.5
	for <iommu@lists.linux-foundation.org>;
	Tue, 07 May 2019 11:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=xQdUAH3uEk3t1d6Jj7xUw13R/CaPkyyhVapQPFRdetk=;
	b=CKfT17s5u156qoURACNpoEvFBYOlF+kduWvc2mdJZAaY3OsyaO3IGwnJc18r9iEjdy
	FwDG1Cn/5D/56r0oWXkURSAVW0kIajFEX3SRdp1vC8l6Yqo/Nj32PAHhK0EEJ0DEmzDC
	srdYUcNCe71sEKzCs4MmpDI4+65FXLVs6V2T0kvvPv7ILHMiVccn+h9vCdhSnOQg0H5e
	4ObN733JL+UvGzgmipDcQKpA4sLUsuxsIbiTBipE9R0kWO0j5IBZQhffA4LcvVzqFqe3
	tifsEnmMKbMKGbdfaoAU6toMIYCeZ41/xaU83tKQBNUgcOuu6wJ7PiBY5IKYtQmCgJU2
	bOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=xQdUAH3uEk3t1d6Jj7xUw13R/CaPkyyhVapQPFRdetk=;
	b=ZGdM7GnCOzQ4q8mFZwe4s+CJ2BPeg6sDJGFZMP6djf7kQBgHOMqQiQy0d6dxu/b/sr
	7i5bcT3YIIrw3Tbb1zUcLdWuuQJHadU8XOWnlO1jsa0AbsPoXi4u02sBzkI9SfjxcVpX
	LCW9i3N18N1WkdMfrK3C9ZjlAqqWppNBMZyLC5KJluA8GC12YRK0dht49hHkzOdNOcXN
	zcL/FpspE5aLBt+ppmH3H5MdPgDdx1hlqGPK0VAV3tokOU6VWd1Bjr9mTTs1+nWCR9E9
	Zf567s2Rj+lIkcNCSjTrWpMURznNJU+zfTfK38y1ND4oyBkXahPJCNOylonMs/5KeQYk
	4dog==
X-Gm-Message-State: APjAAAVQNw9E/2oNFHQTJTj2svKy6iuTEMjTRpZpobMc/tRlS7Q00Fqv
	Eyl7+yC+uYWDwOqWxLtN3fi0+ImjSOFAkmy5/6j9k2GHkC0=
X-Google-Smtp-Source: APXvYqxzmRadKVp3T8KDDcYYe8XgbumhBoqD8DhvdaSDe2jqiUwdFOrm56mx8rEqMIT4DIRlZRJnLgrHJoC4YOAbai0=
X-Received: by 2002:a2e:8018:: with SMTP id j24mr14805302ljg.149.1557252333200;
	Tue, 07 May 2019 11:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190418175744.6229-1-kevmitch@arista.com>
In-Reply-To: <20190418175744.6229-1-kevmitch@arista.com>
Date: Tue, 7 May 2019 11:05:21 -0700
Message-ID: <CAGz=Aa_MhGec1ignde-2tJRvGg3aMrtD-HCVXLiA5wtrTq1S0w@mail.gmail.com>
Subject: Re: [PATCH 0/3] handle init errors more gracefully in amd_iommu
To: iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
From: Kevin Mitchell via iommu <iommu@lists.linux-foundation.org>
Reply-To: Kevin Mitchell <kevmitch@arista.com>
Content-Type: multipart/mixed; boundary="===============4006126612075830774=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

--===============4006126612075830774==
Content-Type: multipart/alternative; boundary="000000000000258ddf058850100e"

--000000000000258ddf058850100e
Content-Type: text/plain; charset="UTF-8"

Sorry to nag, but did anyone have any comments about these patches? Is no
news good news?

Thanks,
Kevin


On Thu, Apr 18, 2019 at 11:14 AM Kevin Mitchell <kevmitch@arista.com> wrote:

> This series makes error handling more robust in the amd_iommu init
> code. It was initially motivated by problematic firmware that does not
> set up the physical address of the iommu. This led to a NULL dereference
> panic when iommu_disable was called during cleanup.
>
> While the first patch is sufficient to avoid the panic, the subsequent
> two move the cleanup closer to the actual error and avoid calling the
> cleanup code twice when amd_iommu=off is specified on the command line.
>
> I have tested this series on a variety of AMD CPUs with firmware
> exhibiting the issue. I have additionally tested on platforms where the
> firmware has been fixed. I tried both with and without amd_iommu=off. I
> have also tested on older CPUs where no IOMMU is detected and even one
> where the GART driver ends up running.
>
> Thanks,
>
> Kevin
>
> Kevin Mitchell (3):
>   iommu/amd: make iommu_disable safer
>   iommu/amd: move gart fallback to amd_iommu_init
>   iommu/amd: only free resources once on init error
>
>  drivers/iommu/amd_iommu_init.c | 45 ++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 21 deletions(-)
>
> --
> 2.20.1
>
>

--000000000000258ddf058850100e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Sorry to nag, but did anyone have any comments about =
these patches? Is no news good news?</div><div><br></div><div>Thanks,</div>=
<div>Kevin<br></div><div><br></div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 18, 2019 at 11:14 AM Kevin M=
itchell &lt;<a href=3D"mailto:kevmitch@arista.com">kevmitch@arista.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This =
series makes error handling more robust in the amd_iommu init<br>
code. It was initially motivated by problematic firmware that does not<br>
set up the physical address of the iommu. This led to a NULL dereference<br=
>
panic when iommu_disable was called during cleanup.<br>
<br>
While the first patch is sufficient to avoid the panic, the subsequent<br>
two move the cleanup closer to the actual error and avoid calling the<br>
cleanup code twice when amd_iommu=3Doff is specified on the command line.<b=
r>
<br>
I have tested this series on a variety of AMD CPUs with firmware<br>
exhibiting the issue. I have additionally tested on platforms where the<br>
firmware has been fixed. I tried both with and without amd_iommu=3Doff. I<b=
r>
have also tested on older CPUs where no IOMMU is detected and even one<br>
where the GART driver ends up running.<br>
<br>
Thanks,<br>
<br>
Kevin<br>
<br>
Kevin Mitchell (3):<br>
=C2=A0 iommu/amd: make iommu_disable safer<br>
=C2=A0 iommu/amd: move gart fallback to amd_iommu_init<br>
=C2=A0 iommu/amd: only free resources once on init error<br>
<br>
=C2=A0drivers/iommu/amd_iommu_init.c | 45 ++++++++++++++++++---------------=
-<br>
=C2=A01 file changed, 24 insertions(+), 21 deletions(-)<br>
<br>
-- <br>
2.20.1<br>
<br>
</blockquote></div>

--000000000000258ddf058850100e--

--===============4006126612075830774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4006126612075830774==--
