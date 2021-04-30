Return-Path: <SRS0=uVFq=J3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0311C43460
	for <iommu@archiver.kernel.org>; Fri, 30 Apr 2021 22:50:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E946128C
	for <iommu@archiver.kernel.org>; Fri, 30 Apr 2021 22:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E946128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 378566FA20;
	Fri, 30 Apr 2021 22:50:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f4MXLhiraEUv; Fri, 30 Apr 2021 22:50:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25F256F986;
	Fri, 30 Apr 2021 22:50:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFB39C000E;
	Fri, 30 Apr 2021 22:50:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 443F4C0001
 for <iommu@lists.linux-foundation.org>; Fri, 30 Apr 2021 22:50:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 329DF6FA20
 for <iommu@lists.linux-foundation.org>; Fri, 30 Apr 2021 22:50:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id frz1Wfqe3KOt for <iommu@lists.linux-foundation.org>;
 Fri, 30 Apr 2021 22:50:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1CC0B6F986
 for <iommu@lists.linux-foundation.org>; Fri, 30 Apr 2021 22:50:19 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 h14-20020a17090aea8eb02901553e1cc649so2544525pjz.0
 for <iommu@lists.linux-foundation.org>; Fri, 30 Apr 2021 15:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
 :references; bh=16/dtgglXPhTLhotwiWNpu5uwDUYzC2lKFh3DLa1Hx4=;
 b=PQh2dt8gfZQLbTOx+5X49nw58W9XQe0SF5XUL0UdMy2a2yUgrs3eR3D59/5TixELZ9
 3ynAu1Iu99ssHH6ryOu+RXkgNjaTuf9FEwmMU7XmylKrjtQYeRRO3aNW6gLKGNDeW6Oc
 XfZ0EScSEqfscXh7odVRPWJZ4XOVMSYdSpBU/135Y5g0CVP3+7V/dzmQZnMTb18w9ZCL
 E1v0Q1tqonZ0nmAVlhdx1l/CZXFLEYxfK5s3mw3Dwva+nlvydY4ygXq38rybbM0bPwVz
 Q+iJUyepcWX/ApREea50n06UwT8RTbDzkxAph162hhaLiM5Ct47fHpYa1xIVE1HF4v6X
 w+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:message-id:mime-version:subject:date
 :in-reply-to:cc:to:references;
 bh=16/dtgglXPhTLhotwiWNpu5uwDUYzC2lKFh3DLa1Hx4=;
 b=CbyuOxsLkS9WIUd2xEXQZg01lUOiBNoTZzqzEvOe5hFiB7PMIiqIrIL6drMv9UhGU4
 fR0Jh1kLnvmImwFfZjJmnsi0g6KwvdDbWOnGGzIwLV8IYwA//Vyn9X926t+Xorimb0sY
 fap/fWu4ndPN6MTRvY0QFLnJq70fxxOl8zVsTibkrLq/CziMCFMPDkE5pw1QMdtAxwP6
 oVPDx5p9hPys2Zd8kOYxJH1auKfgErJBI7Fc7HX4+BXIFvuvQ2GpEPmdsEVk/5VkMr8v
 GdX7tmmxhEEXOoKm/GxdraaHN2euTmAO1BBsiNsS6kIL2wXA2QGssCxkh++W5HL6xXfe
 2Pkg==
X-Gm-Message-State: AOAM533Em2f8dUwMQ6YS+ybKCj7/kag2Dt3+oXdPki3cPQ1gefh0h7Te
 3RrkpYtALDBLcv4u3AWsk3A=
X-Google-Smtp-Source: ABdhPJwu8fcqqjV2X7H3OGTmr1JB4BCD/RIOt6MROYUT4+1TMGnf5Fmu6bskgXZtpR8x6aVq0f++RQ==
X-Received: by 2002:a17:902:b18f:b029:ec:7ac0:fd1a with SMTP id
 s15-20020a170902b18fb02900ec7ac0fd1amr7627001plr.84.1619823018324; 
 Fri, 30 Apr 2021 15:50:18 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net.
 [24.6.216.183])
 by smtp.gmail.com with ESMTPSA id a13sm3884882pgm.43.2021.04.30.15.50.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Apr 2021 15:50:17 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
Message-Id: <3D6CEB0B-101D-4C40-9BFB-68ABC85B084D@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [PATCH v2] iommu/vt-d: Force to flush iotlb before creating
 superpage
Date: Fri, 30 Apr 2021 15:50:14 -0700
In-Reply-To: <YHhJ/0b5i55zGib7@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
References: <20210415004628.1779-1-longpeng2@huawei.com>
 <YHhJ/0b5i55zGib7@8bytes.org>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 stable@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gonglei <arei.gonglei@huawei.com>, "Longpeng\(Mike\)" <longpeng2@huawei.com>,
 David Woodhouse <dwmw2@infradead.org>
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
Content-Type: multipart/mixed; boundary="===============0356615058345226777=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0356615058345226777==
Content-Type: multipart/signed;
	boundary="Apple-Mail=_5772B81F-3D79-4A46-BB6E-A83FEA1C4D1A";
	protocol="application/pgp-signature";
	micalg=pgp-sha256


--Apple-Mail=_5772B81F-3D79-4A46-BB6E-A83FEA1C4D1A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On Apr 15, 2021, at 7:13 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> On Thu, Apr 15, 2021 at 08:46:28AM +0800, Longpeng(Mike) wrote:
>> Fixes: 6491d4d02893 ("intel-iommu: Free old page tables before =
creating superpage")
>> Cc: <stable@vger.kernel.org> # v3.0+
>> Link: =
https://lore.kernel.org/linux-iommu/670baaf8-4ff8-4e84-4be3-030b95ab5a5e@h=
uawei.com/
>> Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
>> ---
>> v1 -> v2:
>>  - add Joerg
>>  - reconstruct the solution base on the Baolu's suggestion
>> ---
>> drivers/iommu/intel/iommu.c | 52 =
+++++++++++++++++++++++++++++++++------------
>> 1 file changed, 38 insertions(+), 14 deletions(-)
>=20
> Applied, thanks.
>=20

Err.. There is a bug in my patch, and some other problem. I will
investigate and get back to you.


--Apple-Mail=_5772B81F-3D79-4A46-BB6E-A83FEA1C4D1A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmCMiaYACgkQHaAqSaba
D1oZ4Q/+Jj4yXux596UIVxLwjOM4+uRS3ogEzW8mp/ULCCWdPlcpGflYqzuNIQdl
txomPflOeOJdCfNR07pjaWktYzMSJo5AqcljhiBXRn3As8Folmq5OaAzvN1OOfnh
RIuUMnUUWok+3gzKM3c8KanBdIaoIryLcBW1uZn7f74JytPjIO7y/sOf9f1LGzkT
cw/VAHuF8pMYtW1flj+N15aqMhI0BRrvEZgarT3qU/eTZd/1W1I1WrAxPeNFPTkz
7Svx8uvznKmzqNaG/z9ujYELhtHutNzA2R1ky3eAQ7JdVn0HwPF0jqlgkeKe6LF4
uFR2OCqLu52RgOCME/w6jqTYnbJti9u7npbCbWxZremUj/ghf9QUoe8VNFlkmgI4
Het2C5n53PrzqYKahXIMpsdlYxzmNqfTmve9BPhWVR2s0/4UqKIwLaBB6RmUqMYV
MpM1Eh1RoBMRuTroQJ6Wztg7er9pHkb/SUB25WdK+Zxpkd1fd4p+zs86OM/6YRY2
KBlqLFfco3OzGlxvvKOFJC4idYaFN3YsyIs8DMhpqmDKTHLlEocgRrFMoPCXl4XS
R7LWf0rEfvYeoOTm1+uM+F5uj8oI7ZR61mNibegQE4IyxtTMxavp4lI/5+yYfU0Y
WhjOyMmqQ+TqOWHNV70cdUOb/s0wjKXw4mCk+axasUCY0iy69xc=
=lcNo
-----END PGP SIGNATURE-----

--Apple-Mail=_5772B81F-3D79-4A46-BB6E-A83FEA1C4D1A--

--===============0356615058345226777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0356615058345226777==--
