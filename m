Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991709;
	b=tLVYXAa8Dd0+Gci8w+Osd9r2C75uHOwt6tkn4PVTZudj0BNPfZ1ny3G7pAonkfxU9FNZ
	 mTD5O3xIhojFGpThMdwphSzH9dCWAFYCA1Xdq33rvsqx2JFFSuu8ZJHftMCsBM6alv1hq
	 teZF6XJ9808dxcqGWyhdsyR+huVV1tpF/4Qq8hvsYvGF97j6T4gxiSuZvw+HHg2Uo3Tbc
	 u/xbkmjwaehTpipWjdrKeM8y1iqNiCXmBUIpW3FmqryFdP1lOSMS5yLqgz4qXPwV46YDl
	 JhSamhcfAZlVx6kV5Z+N6EK60HV21YT7AAzh46SP2G87qb3GkOVMk5vKr2kbGwG+wNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991709;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1Gdrh4wEdBMHBPOr+MFiKo+xNYI96TJ5s+2kswuBKKc=;
	b=3P0w2FBJqiyvY5GPEco+RR6xBavrc08w/KkBBikaBrmA6IWEelFpsKPQoAJBTmJBT1Bl
	 daSZk0QNLK9G65NPRgpfaHQq32CHQY6SBrDrRVJ496QFXmzFyrlcZRWlen351nhBevo8e
	 46/BCtqqkm2XtF5dZp2uuCSRmIZ6DW8TJBQ1Cb4qHG1q5LnPoz+D8I2gyLDoQcep1EDS5
	 8wpl6eEPu3CGthQ4HjKuRoum/ngppzlA+c591GVVG8ivwL9LPICJMfnBtl6pahzGBIxMC
	 FRkVbx1RxY1W2tr5fVtQFg19kpJwXFp22MtkhEPXKWbuIuOlv32XVqQ5fYD2dBsQRRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=ovZXyJBD;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=wrli8nWR;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B573606A329
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 19:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B573606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=ovZXyJBD;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=wrli8nWR
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6IvNhZ2685785
	for <iommu@lists.linux.dev>; Fri, 6 Nov 2026 14:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=1Gdrh4wEdBMHBPOr+MFiKo+xNY
	I96TJ5s+2kswuBKKc=; b=ovZXyJBDDK84T13yCHFkFxGeuKGHjGBHuuRjbBeC7d
	0oS+HT8+fRUcnsK9OU9SBedWWyF6Axn7d6OFZhRMQB/DPvFJTlyb9T7T3ToSTwRb
	Bms+nOGBVWQulVpn+FimaO31r/iFEwgWpKi59zgshY4A31D2B9CzxQ8CxJCVOSc9
	gc+WVwpFgQxVgOywFf6wrwaHDznjaFWw3SFW+Jd+vRdKHfDjWscTCzv6XXRShWPs
	ZQguodVPGHaMFU0wVzSOTm/r1Wu9DQlw12tkq1O+Mdy1nGPLsfAC/1h3p/xifTHo
	VOeATxgtwRpc1WLV4MzeGAOGX1ywPWFdVBFv1cx3rQmg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hsky6rctp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 14:01:46 -0500 (EST)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-999a240f2e1so100484241.1
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 11:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793991706; x=1794596506; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1Gdrh4wEdBMHBPOr+MFiKo+xNYI96TJ5s+2kswuBKKc=;
        b=wrli8nWRleWtkOi1lNzg/XchKr6s4VMm9kIfSHacwidQjC6CTBmmaSQa/mM6NvgtKc
         sPoq4Lex7l8p+HkXkQt6YALnLUPTSh/5pDzvNFWoFzdOqmtMQcTxnruwvTF4Sa1nl1Uc
         3NyDMI05hn97G7t/nHfgUZjnXNzPQM7tkzM8ZJafm8WP7wIpWTicBJ0VpiW8d+lh3/X8
         PlyGElNMNcKwZjw251vpoglJgFGjwyAztl/C94aPO58Y8cURNng/onsSGfsHEY0jHQhG
         J1TLEZQF+yi5SmSMnDTdeDvhebLvoV4OGlqBP1xWcxzjnolg/IsMAH+nO6NXYBdXGNVB
         nFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793991706; x=1794596506;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1Gdrh4wEdBMHBPOr+MFiKo+xNYI96TJ5s+2kswuBKKc=;
        b=b2uKSJgO49tr4XPO9wm2dqU5VqO4q8KbTQlMTJc56eA4wUjgtL7EUWzfzepZy46l2H
         8qvulM1Zvvb0Xv1QXcQC5BUNyHgA/IRBxNcpY0IDu5FgpWmcGZbEiMl6O11ypoTWZe3D
         yAqnlNTFtCWRbZ/4QjslaPMIvyA5wfOAu7C0u9Vl5pPOTNQ2M9waEDRqZ1iQhDnMiaj3
         HGuAnSTkW7VxFsUgXjs10yUQy7uAi3A0Pkh6FsN2/S7qnsJV5ePVn5rFCrnLaJ+uZpoh
         +i3WNy7q2vAL6njD3tOcsEul3JZg2Wg/2oFTGODjN+pp1kS5NgHwS90g0BEOLM/jO3TC
         4G8A==
X-Gm-Message-State: APuU4Z9kZvGvAPJ8hqaolBzW0s79/x2+/FeeamawB/eW082ayXBJrOQr
	ciO2C1OC2Tn5BQxHJKkGYJZLLaWrCRAMqCwNsPUQ1ebqAlDa0tmk/QjJeq8V82vXfUh1Sj4/W03
	g4BmPv3hWVJG728jQwN3chA3iPOKF3Km0gL5OvZ9WuZp7m6KkBvG9
X-Gm-Gg: AYBFou14rt7F8m9sE8jfXmjnN/5ETGHp+BB8sDa7OARICIPjucIEMmOBpsyBK9pSGc/
	9YzX+khFrMBYySrxccWe1LAsWxAKZCm4nXj5tBzGGEvYX/XZHvwwXerTI4cedKRAqGvppH7cbhB
	TP24bKQaTIGR+FQ8kzf+Ah7pDCDjZEXzdQfp/OFcuIe8lcjuV5jCpmT0wIP60xsjZX1dSoch+x9
	i90j5VA6vEXv/2M71PdoNLiccSGGGRvZzP1yybcbQSokU9xlweCrt4zBerFlLX4ipAFVWXUhTOW
	hQke8d0EjnkKADYHFmE9ut6MJ4q5rBc8Uz5V2DvZ/GdJpkgjpGZ8ZxHBzH1uzSqhyf6liTdX0nk
	mnA+Yr2Pcz/hn2sXWzSv/GyuW8OVMOaW9JGIOJyW60O8Cmuz3pc1Y5kNHUuv1kgqHhtkeeVvHmw
	DQdjmRSNPQyEWm+I1J4pX1
X-Received: by 2002:a05:6102:54a4:b0:7c5:4da3:aefb with SMTP id ada2fe7eead31-7d2a16eba5dmr1691795137.34.1793991706238;
        Fri, 06 Nov 2026 11:01:46 -0800 (PST)
X-Received: by 2002:a05:6102:54a4:b0:7c5:4da3:aefb with SMTP id ada2fe7eead31-7d2a16eba5dmr1691523137.34.1793991703397;
        Fri, 06 Nov 2026 11:01:43 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-224.net.columbia.edu. [128.59.176.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6a71bfesm27276376d6.25.2026.11.06.11.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:01:42 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v2 0/2] iommufd: remove the last use of
 set_page_dirty_lock()
Date: Fri, 06 Nov 2026 14:01:18 -0500
Message-Id: <20261106-iommufd-folio-dirty-v2-0-3f0b0be58c4b@columbia.edu>
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
X-B4-Tracking: v=1; b=H4sIAP4j7moC/22NQQ6CMBBFr0JmbQ0t2hBX3sOwKO2MjAFKWkokh
 LsL6NLlS/5/b4GIgTHCLVsg4MSRfb+BOmVgG9M/UbDbGFSutMzlVbDvukROkG/ZC8dhnEVpaqK
 LKiUVBrbnEJD4fVgf1Zdjql9ox121LxqOow/zkZ3kvvsVCvm3MEmRC2WRtHbKaSfv1repq9mc0
 SWo1nX9AK+THz/LAAAA
X-Change-ID: 20261015-iommufd-folio-dirty-8abff4281f3a
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jpb@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793991701; l=1664;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=/v9Cq5RBHqPm5dYVRd0BBFfZIinHb5elOrJG9qNMuNs=;
 b=VqR1IDMjKgEHAcXeFY2Qa1MqVCmF+aYUMFO6uHZDkNoQFXtyWzyELjq9wDSQVYm+QY9mcQ5r4
 8mJI2BQbDz6Af9m9B4ONtGc8yXuJCQqKbPWuYjiCwmNDR2MVoZoLfmM
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: aF7o_1zzwEVaFUiIXkIHtWQ-vqMIkS9P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3NSBTYWx0ZWRfX9izdeQTXVihD
 8N0BbX57ORzEc6tweMDNVk2bXX43lhrvV6h/2nlAtiEUDGrEmBS9RxkNVxWvStsPfQEq4hkchoH
 Uu2ZUZ91Mx27mgdnfaopA/5wU/kNCfxq05D5iWifzHqf8DoOd9XyWsMsWdRqkY3GEOw1iWsrPnC
 oRxz47XLli3Jw2PWjwDh2mHN7itmTMBqqdAUQ4+SeX6Bl9codFiE+yWkTlG9hL/6rZKo3vJseHX
 vJCdOlg1Q0hBpFoUJRN1Y8ujN+toFfaiqWyimVPb4uguOhjt1avd7RPqEbHDQ92Mq5dRNfWIHIM
 w1+4K+QdSccfIlAB4n2TEc2VjldlJv4zF275hpWQNGfj9tFmawgw9n1wi5hwj/yH3GLDM0te4Wj
 xpllrEJarrJkwPchPOHK/nyHhq4NCpmNcjMxAXd/7XjCaET6bcyybr6WKdTxgTRVW5mRwpSMxkg
 snlltxN5uVarZSG8IGw==
X-Authority-Analysis: v=2.4 cv=ae70Dhot c=1 sm=1 tr=0 ts=6aee241b cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=bIa82ERlpw6mw/X9g1H6cQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=bC-a23v3AAAA:8 a=J-kmklhjSyCjd-MEBfQA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: aF7o_1zzwEVaFUiIXkIHtWQ-vqMIkS9P
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3NSBTYWx0ZWRfX8twTCVPjiAub
 03Awtx0ED3WdJKuzQC6xs6eQnrpLbJjzCITiSsdjLOfFUMMby5K2t0+CcjzcHK+VHyI2l9brN5o
 PwJq9kovtciGcqYLsZ+/sfjAaEXvIa+LzdA17aVZwY/N3fbjfqXa
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11958
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=10 bulkscore=10
 adultscore=0 priorityscore=1501 lowpriorityscore=10 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060075

batch_rw() copies to and from pinned user pages one page at a time and
dirties each with set_page_dirty_lock(). The second patch walks the pfn
batch a folio at a time with memcpy_to_folio() and memcpy_from_folio()
and marks each folio dirty once. It removes the last use of
set_page_dirty_lock() in iommufd.

The issue fixed in the first patch was found while testing the second:
iommufd_fail_nth turned up a dev_iommu leak in iommu_mock_device_add()
under kmemleak. The fix is independent and could go through the iommu
tree on its own.

Tested on x86 under virtme-ng with KASAN and lockdep against the iommufd
mock driver. The selftests and iommufd_fail_nth all pass.

With ftrace timing iopt_pages_rw_slow() through the mock driver on a
non-debug kernel, slow-path writes to THP-backed pages drop from ~1310 to
~930 ns/page (now the same cost as a read), and writes to 4K folios drop
~9%.

---
Changes in v2:
- Add tags (thanks Jason!)
- Allocate the fwspec before dev->iommu, per Jason Gunthorpe.
- Fix the Fixes tag, per Robin Murphy.
- Link to v1: https://patch.msgid.link/20261031-iommufd-folio-dirty-v1-0-2cef66d2d6d1@columbia.edu

---
Tal Zussman (2):
      iommu: allocate the fwspec before dev->iommu in iommu_fwspec_init()
      iommufd: copy to and from folios in batch_rw()

 drivers/iommu/iommu.c         |  8 +++++---
 drivers/iommu/iommufd/pages.c | 35 ++++++++++++++++++++---------------
 2 files changed, 25 insertions(+), 18 deletions(-)
---
base-commit: 04bcf84613346b973a8cc0c59238b6b5bc902688
change-id: 20261015-iommufd-folio-dirty-8abff4281f3a

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

