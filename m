Received: from www287.your-server.de (www287.your-server.de [88.198.176.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B5118C31
	for <iommu@lists.linux.dev>; Thu, 11 Dec 2025 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.176.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765490513; cv=none; b=A7D/BTtbL032zvBu4GrVxCWDj7EDqSKWJWXl6VSH1LnvBLw6B5wROBTbR5AAtox16o4jX7T9c4F+DFJUW5flh/oQDiGexnzEA22wk4c5OXd53KivGbmHUMfwgKGG4rp3jkdXKg7WRu382a67cYDsT+n9EB5b49L1shdbaMpvFvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765490513; c=relaxed/simple;
	bh=kRAeJeAqFF6qTSIzhDccgQu9DvrQyctKnGi+brs+J1o=;
	h=Date:From:To:Message-ID:References:Subject:Mime-Version:
	 Content-Type; b=ZdDzqtpzb6AcG0f9UtmR7uGX8qVDaAPFMx+Kt9WdfUOETQTBrOsj5j4keRrRdvd2gcI1XGZGjdw6zmd0PU4M88qJA6psA7TRrXl3kWROP7dcIqJZ9Gjt16UeqIDV4EsFx4tQ9wg6nnu+bHwJhClBrrIwgCorJKpU2sGLdkOghrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ymy.be; spf=pass smtp.mailfrom=ymy.be; dkim=pass (2048-bit key) header.d=ymy.be header.i=@ymy.be header.b=g4IIk+yM; arc=none smtp.client-ip=88.198.176.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ymy.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ymy.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ymy.be header.i=@ymy.be header.b="g4IIk+yM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ymy.be;
	s=default2406; h=Content-Transfer-Encoding:Content-Type:Mime-Version:Subject:
	References:Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To;
	bh=ebXAvMu7KWFKn8MPf7ZJj4XZc0Wu/D795iQp6fvoZkk=; b=g4IIk+yMk0MlLJkLczwpjd5jdg
	bRn9sk4XrPZQC8cMJDptOmzl39jZpEjOU9jsQ8Rjs3qmfO7uwY6RKyyTlSeevPXKdFiOsaeuJ8EUO
	cV7EU5PbpCJ3pWNm6by1mxJuA1jVbhvLcWzJupXAIb4R9InBflUkrVTVHWBm4uNF2MooRWAggaacC
	IfpkH9Hfc7Kr/KIwt6vnskYDZ2+32/CkV0xuXQ+qIQyg1/wSgEdHnXt3nS4uAMg2cmus3HNW7rPRx
	xJdWdQzvrNcD8scx7vmXksTJwYkvMnOF5HEvBE6Rm9SwEp4axHGLjKpEiIaexaKa/T0aK6m38WAUg
	v10ct/TA==;
Received: from localhost ([127.0.0.1])
	by www287.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <iommu@ymy.be>)
	id 1vToj6-000Olw-05
	for iommu@lists.linux.dev;
	Thu, 11 Dec 2025 23:01:31 +0100
Date: Thu, 11 Dec 2025 22:01:31 +0000
From: Willi Junga <iommu@ymy.be>
To: iommu@lists.linux.dev
Message-ID: <20251211220125.45768.9a90cbaa-59f2-4825-8c6e-d37510545e8d@z.ymy.be>
References: 
Subject: amdxdna seems to expect IOMMU handling since 6.16
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="--==_mimepart_693b3f3845ae5_ada2fe5440375";
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Organization: ymy
X-Powered-By: Zammad - Helpdesk/Support (https://zammad.org/)
X-Mailer: Zammad Mail Service
X-Virus-Scanned: Clear (ClamAV 1.0.9/27847/Thu Dec 11 10:25:06 2025)


----==_mimepart_693b3f3845ae5_ada2fe5440375
Content-Type: multipart/alternative;
 boundary="--==_mimepart_693b3f384494f_ada2fe54401e3"
Content-Transfer-Encoding: 7bit


----==_mimepart_693b3f384494f_ada2fe54401e3
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

using Linux in Dom0 on Xen (QubesOS) since Kernel 6.16 the graphic driver=
 didnt load.

First an Issue here
[1] https://github.com/QubesOS/qubes-issues/issues/10275
Then suspected upstream issue here
[2] https://gitlab.freedesktop.org/drm/amd/-/issues/4656

After some bisecting i got:
------

7c8896dd4a2a27c84b04dcf0990e6f6b118cb6b2 is the first bad commit
commit 7c8896dd4a2a27c84b04dcf0990e6f6b118cb6b2
Author: Jason Gunthorpe <[3] jgg@ziepe.ca>
Date: =C2=A0 Fri Apr 18 16:01:24 2025 +0800

 =C2=A0 =C2=A0iommu: Remove IOMMU_DEV_FEAT_SVA

 =C2=A0 =C2=A0None of the drivers implement anything here anymore, remove=
 the dead code.
-------
after suggesting to not load the amdxdna module the system finally booted=
.

Looking for Issues in amd/xdna-driver i only found one which suggests tha=
t xdna expects iommu handling from linux, but thats happening in xen.
( maybe a clue [4] https://github.com/amd/xdna-driver/issues/704=C2=A0)

I hope=C2=A0 this the right mailinglist for the issue, DRM/amd suggested =
to write here or dri-devel.

Let me know if i should provide logs or rather write an issue at amd/xdna=
-driver.

Best Regards,
-Willi Junga

[1] https://github.com/QubesOS/qubes-issues/issues/10275
[2] https://gitlab.freedesktop.org/drm/amd/-/issues/4656
[3] mailto:jgg@ziepe.ca
[4] https://github.com/amd/xdna-driver/issues/704=

----==_mimepart_693b3f384494f_ada2fe54401e3
Content-Type: multipart/related;
 boundary="--==_mimepart_693b3f38455ce_ada2fe5440213"
Content-Transfer-Encoding: 7bit


----==_mimepart_693b3f38455ce_ada2fe5440213
Content-Type: text/html;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html dir=3D"auto">
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8"/>
    <meta http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge"/>
    <style type=3D"text/css">
      body {
        font-family:'Helvetica Neue', Helvetica, Arial, Geneva, sans-seri=
f; font-size: 12px;
      }
      img {
        outline: none;
        text-decoration: none;
        -ms-interpolation-mode: bicubic;
      }
      a img {
        border: none;
      }
      table td {
        border-collapse: collapse;
      }
      table {
        border-collapse: collapse;
        mso-table-lspace: 0pt;
        mso-table-rspace: 0pt;
        border: none;
        table-layout: auto;
        display: block;
        width: 100%;
        overflow: auto;
        word-break: keep-all;
      }
      table,
      pre,
      blockquote {
        margin: 0 0 16px;
      }
      td, th {
        padding: 7px 12px;
      }
      th {
        font-weight: bold;
        text-align: center;
      }
      col {
        width: auto;
      }
      p {
        margin: 0;
      }
      code {
        border: none;
        background: hsl(0,0%,97%);
        white-space: pre-wrap;
      }
      blockquote {
        padding: 8px 12px;
        border-left: 5px solid #eee;
      }
      pre {
        padding: 12px 15px;
        font-size: 13px;
        line-height: 1.45;
        background: hsl(0,0%,97%);
        white-space: pre-wrap;
        border-radius: 3px;
        border: none;
        overflow: auto;
      }
    </style>
  </head>
  <body style=3D"font-family:'Helvetica Neue', Helvetica, Arial, Geneva, =
sans-serif; font-size: 12px;;"><div>Hello,</div><div><br></div><div>using=
 Linux in Dom0 on Xen (QubesOS) since Kernel 6.16 the graphic driver didn=
t load.</div><div><br></div><div>First an Issue here</div><div><span><a h=
ref=3D"https://github.com/QubesOS/qubes-issues/issues/10275" title=3D"htt=
ps://github.com/QubesOS/qubes-issues/issues/10275" rel=3D"nofollow norefe=
rrer noopener" target=3D"_blank">https://github.com/QubesOS/qubes-issues/=
issues/10275</a></span></div><div><span>Then suspected upstream issue her=
e</span></div><div><span><a href=3D"https://gitlab.freedesktop.org/drm/am=
d/-/issues/4656" title=3D"https://gitlab.freedesktop.org/drm/amd/-/issues=
/4656" rel=3D"nofollow noreferrer noopener" target=3D"_blank">https://git=
lab.freedesktop.org/drm/amd/-/issues/4656</a></span></div><div><span><br>=
</span></div><div><span>After some bisecting i got:</span></div><div><spa=
n>------</span></div><div>
<div>7c8896dd4a2a27c84b04dcf0990e6f6b118cb6b2 is the first bad commit</di=
v>
<div>commit 7c8896dd4a2a27c84b04dcf0990e6f6b118cb6b2</div>
<div>Author: Jason Gunthorpe &lt;<a href=3D"mailto:jgg@ziepe.ca" title=3D=
"mailto:jgg@ziepe.ca">jgg@ziepe.ca</a>&gt;</div>
<div>Date: =C2=A0 Fri Apr 18 16:01:24 2025 +0800</div>
<div><br></div>
<div> =C2=A0 =C2=A0iommu: Remove IOMMU_DEV_FEAT_SVA</div>
<div> =C2=A0 </div>
<div> =C2=A0 =C2=A0None of the drivers implement anything here anymore, r=
emove the dead code.</div>-------</div><div>after suggesting to not load =
the amdxdna module the system finally booted.</div><div><br></div><div>Lo=
oking for Issues in amd/xdna-driver i only found one which suggests that =
xdna expects iommu handling from linux, but thats happening in xen.</div>=
<div><span>( maybe a clue=C2=A0<a href=3D"https://github.com/amd/xdna-dri=
ver/issues/704" title=3D"https://github.com/amd/xdna-driver/issues/704" r=
el=3D"nofollow noreferrer noopener" target=3D"_blank">https://github.com/=
amd/xdna-driver/issues/704</a>=C2=A0)</span></div><div><span><br></span><=
/div><div><span>I hope=C2=A0 this the right mailinglist for the issue, DR=
M/amd suggested to write here or dri-devel.</span></div><div><span><br></=
span></div><div><span>Let me know if i should provide logs or rather writ=
e an issue at amd/xdna-driver.</span></div><div><span><br></span></div><d=
iv><span>Best Regards,</span></div><div><span>-Willi Junga</span></div></=
body>
</html>

----==_mimepart_693b3f38455ce_ada2fe5440213--

----==_mimepart_693b3f384494f_ada2fe54401e3--

----==_mimepart_693b3f3845ae5_ada2fe5440375--
