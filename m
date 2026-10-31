Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793478814;
	b=UPdlqgVRNe0pGXQ0Nw68pKKMgO0Nqhhxm7gF7cyFVbwYunCCot1mjiZoE6e/dV/bWMH1
	 pS2lnURSHyULfnikVwqm5X72OpaEvY793zYJjfKo2mZbvyVI91GJnjEyMtVAybmCAV6F4
	 EVKfgY8o5K4XvxfhKt0JsAknWQM5292dpYOcSb+O9s8y3rNzGWZBxcP1VfAm82BUXN5s9
	 HZ+z9O8+d8YRxfSh38BcfqO71qBDOJEF9HedGWsoTZ+iHJHgBpEdI4fvhB1X3p+m6STlx
	 1xnW0KU29AjJLKt7TQr3e+bn/L4QgUGoVaZIYCRaeqJscqd5lWpMubM4rnSaXOdSfOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793478814;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=SUiGiQ0Y+CFpbO7hs7vpkUK0TSJwBq9jsvGhQh6Op/E=;
	b=UkGgW42hBHqBzbC5D9TQFlb9552gqB4VH6DD27vw9em61GPXaiipdj4xUAwF0fThKBnB
	 tqkyVeeVs1LxG4LSPhnhSzBTpdu5PzDxpOTAmybri5T/Y8WTECZHIN0lChCgMCJw3RtHg
	 o5lJJXUUB6pqIMMxUdpne+N5tJd1MNy8bwPRE4GmQfNfG2hyX3D5N9mmU9jRqjuBSV9PJ
	 AVL9NjTIFkocoyeMQAtZJhCGFwiED8jmXt1C6dYJ9gmlJtCPt/O55PA8Gy7mVTW0ibgZG
	 1Mkc0U/3A5Y6mwKs8KwACMWLvllYaDI9mMnibNQT9KoXJTU5iXv0K07EMdWti7NxZUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=riMMskYR;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=mSLCSc2O;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3918606A31A
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 20:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3918606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=riMMskYR;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=mSLCSc2O
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VDmY0Q061873
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 16:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=SUiGiQ0Y+CFpbO7hs7vpkUK0TS
	JwBq9jsvGhQh6Op/E=; b=riMMskYRDKEVqPF1V9/F+WFmw36SiRakiE1up0oOJb
	KBdVIL1HF2g65uDc2o4i7VXxrEMf7igtE9sTy213J573b2lEBaErATvecMs+jVqM
	r1ypEc9a96wtHAYdoVgwXzIHp35gy//E9I2CVhHnEHckgFeCalqg8Ui1Tn4zczmm
	ZPX0D0qZD0TkYYvJyI0gkjMrLE0HWC2YwuBXLgTaISC/s540iZ/EbiNmrPTgYpzg
	xp0qh61GBeXipwEGqXFlR9pIBqP5YRvsa7CHysuoLP19vX2dZSirk94zeUmsaEn0
	H+OLoAGLns22/i6l6KpUWP9k5cMoPqWWM1AmpbV+rUlw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hnccxu71w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 16:33:32 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-944101e6367so348427185a.1
        for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 13:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793478812; x=1794083612; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SUiGiQ0Y+CFpbO7hs7vpkUK0TSJwBq9jsvGhQh6Op/E=;
        b=mSLCSc2OUu3KzyqS6pDYEK40KI53TQSmNvy8MM4FqU9Irys+4yHvY7PJwI19OKbLMy
         Mw6YlCIrBdXNk2sgpwgm9LsQsWufDlLjs3tAU7xL4Zz4aCi6G2vcq/WMESukcptubaLk
         4QHWU1jTjRPWk3ul5b880O++FKsZxYJO3SNVM0q9xaAS4trvE3ckT3riDNq78PPJCTpU
         BALg3N/RvMbTmvXHUFJmQIRqyCClapplVFFPwdrWkGGl6VPFO3pavhSTL/Y9vBKqOXer
         VAG/SuAm1D1W2TB5YUfGCdjngggvoA2B7gVw66Z7Hkal4/cElQxpjWJyfYvkypQQuZzR
         xVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793478812; x=1794083612;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SUiGiQ0Y+CFpbO7hs7vpkUK0TSJwBq9jsvGhQh6Op/E=;
        b=i3Qkx+i3PJ96B0BKrJW4BuWy6fcNlxUxxCQiDub7MQpkulEnLKkpXOXuU7SbAUf1tp
         J/ed/M6n7sw9rfwCUMzMazLqLAvkMplti/nuXdqFGinnoVht3hMlflKK2Rss3Lddm+WK
         1eYZnt6Rte/VcZRb+6884DzstSiP+TzXrG1UgMAfjoEBX9I5qsH4uqyye7uqhHeAXv/x
         EXJuAkFA7q5fReVi/mFFpoUHw8eMucLi8vp5NiD1ei+PAYWk9gQXIDqz8vq6qq1ryvSD
         SlNyv6pR7fyHa8PtPo0iVFECDwixoxclrldJhgE0EtYAxC/x68ieWetanlEEIb2b+Gn5
         0fAQ==
X-Gm-Message-State: AFq9FYKWbhH2sA7Sj6Wqff4T6X+MXVJvN/5vTm9PHRWW8pMt1JC+KnuK
	LzXRfK4yBBMqwMbNoMH/7G1lyGXxOha5TXAoHFEQ3WswQN+w+vKqAvzJBfQcs1BKVSttaJBT8AR
	n06OFvIYS2y+gI7VjHuba8XVKz5P/AqJUYyoioZaX+/mI72xdELCm
X-Gm-Gg: AYBFou2MdEisuVexBP0O+SBaaTm2nIbo2+YSJmzvN84IsGwkLsuKtl/g11rMI2L+KwP
	c1eogzDVMNgmNPpmNzONPI1I566by7p5eG2XXPbbiANu1aT8+TzZ4i3ojOAJAI42FYDufGt6dA4
	0UbRjLRAigx1Ha7S8T32CzbYwjluMdIEqzTJtih8+O7brdarTzdAIqPEa59LjOU1OPBNDFPifI1
	qplrPnNBZ2zlmhm5EJwHDlJiIyayEt8VW1wVdcZKM7KHGzOPKKVnzAXiLEAs9EIA9J/oFj0dEj8
	Cdzo6xOhAL7rQtq6GBLB4KYSK7QriNhXEISAgFfvpRrmnFx/ZmAj/BNgCbTkld2VADXwy6RyhP9
	lBs9VdpNUZmhLiLl9/M1tDHGRE65GV9IcP9nDdmkJWLK4Fvga423i7fJCs+w=
X-Received: by 2002:a05:620a:6013:b0:93e:5de7:fd45 with SMTP id af79cd13be357-94413382637mr1224532185a.18.1793478811935;
        Sat, 31 Oct 2026 13:33:31 -0700 (PDT)
X-Received: by 2002:a05:620a:6013:b0:93e:5de7:fd45 with SMTP id af79cd13be357-94413382637mr1224531085a.18.1793478811503;
        Sat, 31 Oct 2026 13:33:31 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.155.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b81c74sm10019650f8f.36.2026.10.31.13.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 13:33:30 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH 0/2] iommufd: remove the last use of set_page_dirty_lock()
Date: Sat, 31 Oct 2026 16:33:17 -0400
Message-Id: <20261031-iommufd-folio-dirty-v1-0-2cef66d2d6d1@columbia.edu>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI1Q5moC/yXMwQ5EMBCA4VeROZtEu0vEq2wcSmcYQTctGyLef
 Yvjd/j/AwJ5oQBVcoCnnwRxc4RKE2h7M3eEYqNBZ7pQmcpR3DStbJHdKA6t+GXH0jTMb10qfhm
 I5dcTy3ZfP/XjsDYDtcu1gvP8A2Hxrdl3AAAA
X-Change-ID: 20261015-iommufd-folio-dirty-8abff4281f3a
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jpb@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793478807; l=1411;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=eNe3oAs4Qkr5hSIiUWON/YrrFv+X7yStpz6+TWXlJBc=;
 b=wSTu02Ccl25+NdBAeIyxiHEktfMw0UcSgwzuHdGHGICvU2T1FNmcw2CwKjP11wjvt5B+BZ/4F
 uDFd4B5MfcWBCd3IobPHWNkxqmYvZuaSFF355H2Aw9luNORuzsNJFeL
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA4MSBTYWx0ZWRfX/Zp97Jlwywnc
 CAEMuvCQNFl0vwcaof+n08Ug+sMiwcCuTqnXr4SxmFxm/T90ZL+yevBtAldOOexOdSJDM7083ga
 8jl80YXcwnMTiFhjRv/cdV0I1eK6IEs3GzWNoSIaYV71W2jw0/4udbu7cUUb4iKiHrKjdx/J5Sb
 Eo95PB3JdmGaXcG+YEO8vkWHWzAmKB5SVmG4Zidd4LLU5YSEh33Q8bwk8T9L61Xl0bIkaS4OR45
 gPHt4Zacdl5v9QeV2Tld2+IZj9AamAOTb7a9Q/AGrmeyNAhvVYHqm9ZLVEro4ptWGLgnVB/J9iJ
 bvUuJI7SGf+xKgvBMy6QvYYfbgf110qnLsekobD0gEaPW6S1LbxFrL1by/EdxyJWF5SoOXD6Kf+
 m4JWknfi1Ki75AjIOcREeMrhRa7nZDndcxp06nRZ2MDPDZzCN5r/7ns+vzyJqhZ8Vuwy0YBriLH
 bLT5+JWnYYS1U3TWYBQ==
X-Authority-Analysis: v=2.4 cv=XKSl2ghE c=1 sm=1 tr=0 ts=6ae6509c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=OyQKmhT2Qqi7aVZxTY5mBQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=B_Kq-j8faEqg3xUN6KgA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: mj24SnQ7Sohm9c8ZUGTrtmTHxyf5mdBN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA4MSBTYWx0ZWRfX8TkVsNTIWThh
 gpMbJr+o4Q0q8xXTcqGy2LoTHwOdSmw6jEInxgJ6N+xoDyoQK1Fz4/cUG0vI6B9OLYZk8TwF9Ux
 YwvvIIsL9eqFAul6DNZ2CbjsINGNjqQqEhkrAFkM2F/nGX+8rZGO
X-Proofpoint-GUID: mj24SnQ7Sohm9c8ZUGTrtmTHxyf5mdBN
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11952
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=10 malwarescore=0 lowpriorityscore=10
 clxscore=1011 bulkscore=10 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310081

batch_rw() copies to and from pinned user pages one page at a time and
dirties each with set_page_dirty_lock(). The second patch walks the pfn
batch a folio at a time with memcpy_to_folio() and memcpy_from_folio()
and marks each folio dirty once. It removes the last use of
set_page_dirty_lock() in iommufd.

The issue fixed in the first patch was found while testing the second:
iommufd_fail_nth turned up a dev_iommu leak in iommu_fwspec_init() under
kmemleak. The fix is independent and could go through the iommu tree on
its own.

Tested on x86 under virtme-ng with KASAN and lockdep against the iommufd
mock driver. The selftests and iommufd_fail_nth all pass.

With ftrace timing iopt_pages_rw_slow() through the mock driver on a
non-debug kernel, slow-path writes to THP-backed pages drop from ~1310 to
~930 ns/page (now the same cost as a read), and writes to 4K folios drop
~9%.

---
Tal Zussman (2):
      iommu: free dev->iommu when iommu_fwspec_init() cannot allocate the fwspec
      iommufd: copy to and from folios in batch_rw()

 drivers/iommu/iommu.c         |  6 +++++-
 drivers/iommu/iommufd/pages.c | 35 ++++++++++++++++++++---------------
 2 files changed, 25 insertions(+), 16 deletions(-)
---
base-commit: 04bcf84613346b973a8cc0c59238b6b5bc902688
change-id: 20261015-iommufd-folio-dirty-8abff4281f3a

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

