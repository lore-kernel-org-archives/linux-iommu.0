Return-Path: <SRS0=kdPY=IP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED3CC433E0
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 05:46:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE51764F89
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 05:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE51764F89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8797442FC1;
	Wed, 17 Mar 2021 05:46:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SiJSYwQnV8SC; Wed, 17 Mar 2021 05:46:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 784C64307A;
	Wed, 17 Mar 2021 05:46:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50310C000B;
	Wed, 17 Mar 2021 05:46:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7F29C000A
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 05:46:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C0D7C83EAE
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 05:46:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DDhMzTwy4GTH for <iommu@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 05:46:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C53D383E9F
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 05:46:03 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id g15so348194pfq.3
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 22:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
 :references; bh=Ujp9UfR8Qd2e1W2rb8Yy7Ng5ueLzSwK0qByoLGFBS0s=;
 b=IGyWMaPRak736Km3uapC54943hh9Z69fyJb74NvV7tGffmojDAy2J0TLYmsM/q0Xth
 lC/B+nyXO6PcTCOHS5VLIrwBvOKxSp5YkMWsECi6yGg3N9ieJrWtQAnxEoiga56rDDRa
 B6nJ2M5LoaV+eipBjRBYuvw7qY+YYLxd67IjuRSEgzfL9VDhtKGlgXAo8fUI+kG6AVcd
 lBSRjnZVKXsRNsi1AKlCHP8QT3h01oMkgUyy6XIKEhZKAmro4B5x+Jf0+lW903EEihes
 itZwqExe6BFafZC+2fdMxVwf2SL2n1QXlATFiRAGnfPcHK6jUSIpG+MmzatiiIAu0o+Z
 H3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:message-id:mime-version:subject:date
 :in-reply-to:cc:to:references;
 bh=Ujp9UfR8Qd2e1W2rb8Yy7Ng5ueLzSwK0qByoLGFBS0s=;
 b=VwANFtc0dKAKggdyjwkEe4rbT0LU9MmG07nJAb4KeehDXPgB9+rCUFJ+5+XAYAdirJ
 3rq9QFOy6Dbyfb4c0/iY1Mx03aqtP+NuLRfMrtcU5ZjBlEOh5aWNNVk6CXOSkj8+ib1u
 jt9KJXjyvEOvKUu4aWPo7YL+4/IODrOiW/8Hj/pgERPfjYaGhrD+Yv54LIAxU0fLAV7D
 7CxgIZQTtjGhtEnp3YF6QJ/wGeUTgdneeM97qvFl2PmD0DvpO4Jj7GwZT9injCjV6vof
 uQzOS9Gx4OhU0LKjFGM88oI5/U3qbFls+F38UxbcJIQfw0mQZ+5vnAu+02FtAA6nJ8tM
 lVGA==
X-Gm-Message-State: AOAM532lNPhB/hcecW4J5Prvuc08XPifqOoLbLRrV4vCrcw+LX5aF+a/
 s0rpY3mi3RvFXQds6llOlHg=
X-Google-Smtp-Source: ABdhPJwy8l3t4/GfWpvoU78y2CabIFXac1SEnv5gO5mnbDiGkzd7bDcWBUJZuuhHjMUxa7qaZSRwgA==
X-Received: by 2002:a62:7ecc:0:b029:1ee:f61b:a63f with SMTP id
 z195-20020a627ecc0000b02901eef61ba63fmr2683369pfc.57.1615959963049; 
 Tue, 16 Mar 2021 22:46:03 -0700 (PDT)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net.
 [24.6.216.183])
 by smtp.gmail.com with ESMTPSA id f15sm17787460pgg.84.2021.03.16.22.46.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Mar 2021 22:46:02 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
Message-Id: <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: =?utf-8?Q?Re=3A_A_problem_of_Intel_IOMMU_hardware_=EF=BC=9F?=
Date: Tue, 16 Mar 2021 22:46:00 -0700
In-Reply-To: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
To: "Longpeng (Mike,
 Cloud Infrastructure Service Product Dept.)" <longpeng2@huawei.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Cc: chenjiashang@huawei.com, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 alex.williamson@redhat.com, "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 will@kernel.org
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
Content-Type: multipart/mixed; boundary="===============0633299035729680159=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0633299035729680159==
Content-Type: multipart/signed;
	boundary="Apple-Mail=_32125005-ABF2-433B-8116-AA0CE5BE22AF";
	protocol="application/pgp-signature";
	micalg=pgp-sha256


--Apple-Mail=_32125005-ABF2-433B-8116-AA0CE5BE22AF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Mar 16, 2021, at 8:16 PM, Longpeng (Mike, Cloud Infrastructure =
Service Product Dept.) <longpeng2@huawei.com> wrote:
>=20
> Hi guys,
>=20
> We find the Intel iommu cache (i.e. iotlb) maybe works wrong in a =
special
> situation, it would cause DMA fails or get wrong data.
>=20
> The reproducer (based on Alex's vfio testsuite[1]) is in attachment, =
it can
> reproduce the problem with high probability (~50%).

I saw Lu replied, and he is much more knowledgable than I am (I was just
intrigued by your email).

However, if I were you I would try also to remove some =
=E2=80=9Coptimizations=E2=80=9D to
look for the root-cause (e.g., use domain specific invalidations instead
of page-specific).

The first thing that comes to my mind is the invalidation hint (ih) in
iommu_flush_iotlb_psi(). I would remove it to see whether you get the
failure without it.


--Apple-Mail=_32125005-ABF2-433B-8116-AA0CE5BE22AF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmBRl5gACgkQHaAqSaba
D1okkw//VQJJ39J/JKYVMkgwoAsIhX97StP/+FKhidQwmlC4lnKnDphGUObxcR8d
tFW33ZSpsywfKp1ZQS1Ygbeo9pHSKUiC+jqQb9IPJ7UlkQawfOxkbbJ2LpvwAWoF
YEVnjHfokaAYcop0tGcj/Da9kDBbiSgLd9Djkkwgl2sJiv+2xKC+j2NE09ppRr6X
tJWLFEUSiiJoWbhYsHTLXeiMtjnVYsIKBukqCE9A5uxzEypv3MNG/Ej56wILCx/m
CSQX2oUWbZ4Ngth+0erF6mYfrIvFNncewCzg27N5J2+dbnTvHxWbd/VAMD3vzqmO
+74AjWg8YVpxSqqA+nPouBc20xGJMM6q6QU4SXrV00c2HSoBHxglXsMc+3yiwPYN
Wh2OpP8G8J8DsnzgPKhxHVlTiEELmpw10RQoLnehCooOdOGnu7ALFoF7PWkl+qO5
aoKLQIm+Di2dURMfGR27b9QlByxxvM5B2MePpACp0OKwvrea83msUIve52hpXhZq
+1uAOLTs/mvLMMbzzvVsnPKHswWYULBjsFOKOuSTdgbfUc3tWpNcNlysBXZsDYg6
auFzIRun+IhdxsQQEalxCuEAhr8x3HCR+gkr95avp3G4JKWuwWW3A5ZYwEmP+Y9P
8VPpAZmQj9JFZBZX8Y739iXZ10XOdpA/c0a/sXGuNiYn0IuxvQ0=
=SsWK
-----END PGP SIGNATURE-----

--Apple-Mail=_32125005-ABF2-433B-8116-AA0CE5BE22AF--

--===============0633299035729680159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0633299035729680159==--
