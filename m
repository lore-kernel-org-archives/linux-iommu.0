Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C420C433F2
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B689208C3
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HCVXQcAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B689208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CE74187C47;
	Thu, 18 Jun 2020 15:40:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OeszhnsQzBkg; Thu, 18 Jun 2020 15:40:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 26BEF87C20;
	Thu, 18 Jun 2020 15:40:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0352BC08A7;
	Thu, 18 Jun 2020 15:40:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1FA4C088C
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8960E87C14
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 51tV-X3nk2oj for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:40:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B935B87C05
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:27 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200618154026euoutp02b3486223a535cf039c65258b19ade376~ZrZtze0PU1314513145euoutp02H
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200618154026euoutp02b3486223a535cf039c65258b19ade376~ZrZtze0PU1314513145euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592494826;
 bh=nbh13/xRlTnDhOSh+Kxv0NXU5d6Pqt7iXPYs90aE1m4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HCVXQcAVK6irV3YTdHDxj9XFYB5BB8lZZSYC1d0VzrQFyQE8LcQ4/PVgBxP/lyxf2
 wlpp+AbnAQqwn5yKOTY8fOtzxE7zHHmgcG7JXLcLwulAiucKu23HzHIqPva93xSYVI
 fnRHJ2SP4x/Wb6uP/Mjxnp6M1cQzYEKU9v3vHQBA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200618154026eucas1p2ce5e89ebc9c9113e06f620c9c8b5e34f~ZrZtcL2ic0501005010eucas1p2f;
 Thu, 18 Jun 2020 15:40:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id B6.60.60698.9EA8BEE5; Thu, 18
 Jun 2020 16:40:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200618154025eucas1p1cf27282556c145b4a59527141a340574~ZrZtHADSG1755717557eucas1p1M;
 Thu, 18 Jun 2020 15:40:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200618154025eusmtrp16ec981cf5bf255088963d1a07964c8aa~ZrZtGW6dO2169821698eusmtrp1d;
 Thu, 18 Jun 2020 15:40:25 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-33-5eeb8ae9bd6d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 67.E9.07950.9EA8BEE5; Thu, 18
 Jun 2020 16:40:25 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200618154024eusmtip1e733628c569e66612e73eb95a145512a~ZrZsY---J0709107091eusmtip1v;
 Thu, 18 Jun 2020 15:40:24 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 17/36] drm: radeon: fix common struct sg_table related
 issues
Date: Thu, 18 Jun 2020 17:39:38 +0200
Message-Id: <20200618153956.29558-18-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01SazBUYRieb8+es4esOZbJN5iatqFoIkPTmTQmph+n6Q+mXzVk44Rhl/ag
 1I/EMFqXqUyl1UVmta5hF7HKZaMltVPLCLnGDGKryaVxb9ch/r3P8z7P+7zvNx+OCEZQBzxK
 Ek9LJaIYIWbJrXu/pD86LZsJOWYoOklm6zs55MPBRpQsqrzNI6vzKlHSOGKCG3X3ELJn4RdG
 lpS1c8iCZh9yvmeMQ6rGe1GyW/MEIyvahnhk6+8J9LQ1lWZYw6jyZ+WAertYwKVeL46i1Eim
 jkOpFbeob+vjCJXbpwRUY38yRuXUlAJqTrUvYM8Fy1PhdExUIi318A21jPwyq8TilHuv18qO
 JIM+gQxY4JDwhpMNLRwZsMQFRDGA/e1/ERbMA6hpbEdZMAfg6HgzZ9siy9UCtqEEcGhFhu1Y
 UtYRswojPKHMaG5Y4HZEGoAd2VZmEUIoEKgYbOKaG7ZEEJzqHd0cyyWc4fLzcmCu+YQvVP+Z
 BGzcflhW1bI51MLEd+nSUFZjAzsfT2zOQUya1Nr8zcUhscaDTYYVhDWfgS8W2nlsbQt/6Gq2
 aifYlZvFZQ2pAI7pK3gsyAKwOyVvK9oHDuqXTTfgpghXWKnxYGk/aKzKRM00JKxhn9GGXcIa
 3q97hLA0H2akb72wC5TrXv2Pbf1s2FqNggNvynl3wQH5rnPku86R7+QWAKQU2NMJjDiCZrwk
 9DV3RiRmEiQR7mGxYhUwfbuudd1CPWhavawFBA6EVvyp8zMhAlSUyCSJtQDiiNCO7/+pK0TA
 Dxcl3aClsZekCTE0owWOOFdoz/cqnA4WEBGieDqapuNo6XaXg1s4JIOwgfSnh7UBKeO1TgqV
 Il2Q73rnSotzSRWWseKsXi+S/dQgUV9p1xNno4vV53qLum+6TAWXdpBeMNMWCa13Kz30cbZN
 3FtfdvUg47Hg3yp/Fzgc6P1y6UPKMO52vHBsPijJ78HFnpELTbFKSXbOEr1a/b1kcDm4RzDb
 4Bi4ETcq5DKRIk83RMqI/gFAiE4McgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xu7ovu17HGfz/q2TRe+4kk8W0O7tZ
 LZaub2S32DhjPavF2/tA7v9tE5ktrnx9z2axcvVRJosF+60tvlx5yGSx6fE1VovLu+awWaw9
 cpfd4uCHJ6wOfB6tl/6yeayZt4bRY++3BSwe2789YPW4332cyWPzknqP2/8eM3tMvrGc0WP3
 zQY2j74tqxg9Pm+SC+CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
 Sc3JLEst0rdL0Mu4+GY5W8FysYqtXdoNjDeEuhg5OSQETCS6Jh9i7GLk4hASWMooceHga3aI
 hIzEyWkNrBC2sMSfa11sEEWfGCU2r5zLBpJgEzCU6HoLkRAR6GSUmNb9kR3EYRZYwyxx7/ty
 sFHCAgESu9c8ZASxWQRUJX7NXwNm8wrYSWz+9JwRYoW8xOoNB5hBbE6g+OnjrWCrhQRsJZ5/
 aGODqBeUODnzCUsXIwfQAnWJ9fPAXmAGam3eOpt5AqPgLCRVsxCqZiGpWsDIvIpRJLW0ODc9
 t9hIrzgxt7g0L10vOT93EyMwgrcd+7llB2PXu+BDjAIcjEo8vC9CXscJsSaWFVfmHmKU4GBW
 EuF1Ons6Tog3JbGyKrUoP76oNCe1+BCjKdBrE5mlRJPzgcklryTe0NTQ3MLS0NzY3NjMQkmc
 t0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo53o3srvaR903+bdzuOS2LJbxsRx06O9L6aHTfxl
 /Tq9KVtV2frSW5vrp16tiHHbpvN3ofE+aTEvm77053oH/J9Hvy2//y43T2rn78cPTpkzrZX4
 bB964kuBOvN6NtE3nb5Ms6z8Yk6XnLxs3qhio/Y78EGTV7D6jOkVx9hDZ05WOSIw78wEfiWW
 4oxEQy3mouJEALhs/Nf2AgAA
X-CMS-MailID: 20200618154025eucas1p1cf27282556c145b4a59527141a340574
X-Msg-Generator: CA
X-RootMTR: 20200618154025eucas1p1cf27282556c145b4a59527141a340574
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154025eucas1p1cf27282556c145b4a59527141a340574
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
 <CGME20200618154025eucas1p1cf27282556c145b4a59527141a340574@eucas1p1.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

VGhlIERvY3VtZW50YXRpb24vRE1BLUFQSS1IT1dUTy50eHQgc3RhdGVzIHRoYXQgdGhlIGRtYV9t
YXBfc2coKSBmdW5jdGlvbgpyZXR1cm5zIHRoZSBudW1iZXIgb2YgdGhlIGNyZWF0ZWQgZW50cmll
cyBpbiB0aGUgRE1BIGFkZHJlc3Mgc3BhY2UuCkhvd2V2ZXIgdGhlIHN1YnNlcXVlbnQgY2FsbHMg
dG8gdGhlIGRtYV9zeW5jX3NnX2Zvcl97ZGV2aWNlLGNwdX0oKSBhbmQKZG1hX3VubWFwX3NnIG11
c3QgYmUgY2FsbGVkIHdpdGggdGhlIG9yaWdpbmFsIG51bWJlciBvZiB0aGUgZW50cmllcwpwYXNz
ZWQgdG8gdGhlIGRtYV9tYXBfc2coKS4KCnN0cnVjdCBzZ190YWJsZSBpcyBhIGNvbW1vbiBzdHJ1
Y3R1cmUgdXNlZCBmb3IgZGVzY3JpYmluZyBhIG5vbi1jb250aWd1b3VzCm1lbW9yeSBidWZmZXIs
IHVzZWQgY29tbW9ubHkgaW4gdGhlIERSTSBhbmQgZ3JhcGhpY3Mgc3Vic3lzdGVtcy4gSXQKY29u
c2lzdHMgb2YgYSBzY2F0dGVybGlzdCB3aXRoIG1lbW9yeSBwYWdlcyBhbmQgRE1BIGFkZHJlc3Nl
cyAoc2dsIGVudHJ5KSwKYXMgd2VsbCBhcyB0aGUgbnVtYmVyIG9mIHNjYXR0ZXJsaXN0IGVudHJp
ZXM6IENQVSBwYWdlcyAob3JpZ19uZW50cyBlbnRyeSkKYW5kIERNQSBtYXBwZWQgcGFnZXMgKG5l
bnRzIGVudHJ5KS4KCkl0IHR1cm5lZCBvdXQgdGhhdCBpdCB3YXMgYSBjb21tb24gbWlzdGFrZSB0
byBtaXN1c2UgbmVudHMgYW5kIG9yaWdfbmVudHMKZW50cmllcywgY2FsbGluZyBETUEtbWFwcGlu
ZyBmdW5jdGlvbnMgd2l0aCBhIHdyb25nIG51bWJlciBvZiBlbnRyaWVzIG9yCmlnbm9yaW5nIHRo
ZSBudW1iZXIgb2YgbWFwcGVkIGVudHJpZXMgcmV0dXJuZWQgYnkgdGhlIGRtYV9tYXBfc2coKQpm
dW5jdGlvbi4KClRvIGF2b2lkIHN1Y2ggaXNzdWVzLCBsZXRzIHVzZSBhIGNvbW1vbiBkbWEtbWFw
cGluZyB3cmFwcGVycyBvcGVyYXRpbmcKZGlyZWN0bHkgb24gdGhlIHN0cnVjdCBzZ190YWJsZSBv
YmplY3RzIGFuZCB1c2Ugc2NhdHRlcmxpc3QgcGFnZQppdGVyYXRvcnMgd2hlcmUgcG9zc2libGUu
IFRoaXMsIGFsbW9zdCBhbHdheXMsIGhpZGVzIHJlZmVyZW5jZXMgdG8gdGhlCm5lbnRzIGFuZCBv
cmlnX25lbnRzIGVudHJpZXMsIG1ha2luZyB0aGUgY29kZSByb2J1c3QsIGVhc2llciB0byBmb2xs
b3cKYW5kIGNvcHkvcGFzdGUgc2FmZS4KClNpZ25lZC1vZmYtYnk6IE1hcmVrIFN6eXByb3dza2kg
PG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbT4KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl90dG0uYyB8IDExICsrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uX3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmMKaW5kZXgg
NWQ1MGM5ZWRiZTgwLi4wZTNlYjBkMjI4MzEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uX3R0bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3R0
bS5jCkBAIC00ODEsNyArNDgxLDcgQEAgc3RhdGljIGludCByYWRlb25fdHRtX3R0X3Bpbl91c2Vy
cHRyKHN0cnVjdCB0dG1fdHQgKnR0bSkKIHsKIAlzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiA9
IHJhZGVvbl9nZXRfcmRldih0dG0tPmJkZXYpOwogCXN0cnVjdCByYWRlb25fdHRtX3R0ICpndHQg
PSAodm9pZCAqKXR0bTsKLQl1bnNpZ25lZCBwaW5uZWQgPSAwLCBuZW50czsKKwl1bnNpZ25lZCBw
aW5uZWQgPSAwOwogCWludCByOwogCiAJaW50IHdyaXRlID0gIShndHQtPnVzZXJmbGFncyAmIFJB
REVPTl9HRU1fVVNFUlBUUl9SRUFET05MWSk7CkBAIC01MjEsOSArNTIxLDggQEAgc3RhdGljIGlu
dCByYWRlb25fdHRtX3R0X3Bpbl91c2VycHRyKHN0cnVjdCB0dG1fdHQgKnR0bSkKIAlpZiAocikK
IAkJZ290byByZWxlYXNlX3NnOwogCi0JciA9IC1FTk9NRU07Ci0JbmVudHMgPSBkbWFfbWFwX3Nn
KHJkZXYtPmRldiwgdHRtLT5zZy0+c2dsLCB0dG0tPnNnLT5uZW50cywgZGlyZWN0aW9uKTsKLQlp
ZiAobmVudHMgPT0gMCkKKwlyID0gZG1hX21hcF9zZ3RhYmxlKHJkZXYtPmRldiwgdHRtLT5zZywg
ZGlyZWN0aW9uLCAwKTsKKwlpZiAocikKIAkJZ290byByZWxlYXNlX3NnOwogCiAJZHJtX3ByaW1l
X3NnX3RvX3BhZ2VfYWRkcl9hcnJheXModHRtLT5zZywgdHRtLT5wYWdlcywKQEAgLTU1NCw5ICs1
NTMsOSBAQCBzdGF0aWMgdm9pZCByYWRlb25fdHRtX3R0X3VucGluX3VzZXJwdHIoc3RydWN0IHR0
bV90dCAqdHRtKQogCQlyZXR1cm47CiAKIAkvKiBmcmVlIHRoZSBzZyB0YWJsZSBhbmQgcGFnZXMg
YWdhaW4gKi8KLQlkbWFfdW5tYXBfc2cocmRldi0+ZGV2LCB0dG0tPnNnLT5zZ2wsIHR0bS0+c2ct
Pm5lbnRzLCBkaXJlY3Rpb24pOworCWRtYV91bm1hcF9zZ3RhYmxlKHJkZXYtPmRldiwgdHRtLT5z
ZywgZGlyZWN0aW9uLCAwKTsKIAotCWZvcl9lYWNoX3NnX3BhZ2UodHRtLT5zZy0+c2dsLCAmc2df
aXRlciwgdHRtLT5zZy0+bmVudHMsIDApIHsKKwlmb3JfZWFjaF9zZ3RhYmxlX3BhZ2UodHRtLT5z
ZywgJnNnX2l0ZXIsIDApIHsKIAkJc3RydWN0IHBhZ2UgKnBhZ2UgPSBzZ19wYWdlX2l0ZXJfcGFn
ZSgmc2dfaXRlcik7CiAJCWlmICghKGd0dC0+dXNlcmZsYWdzICYgUkFERU9OX0dFTV9VU0VSUFRS
X1JFQURPTkxZKSkKIAkJCXNldF9wYWdlX2RpcnR5KHBhZ2UpOwotLSAKMi4xNy4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
