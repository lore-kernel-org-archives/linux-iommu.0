Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985306;
	b=qK6K6uGAvPovy7ySyFEIomW8qn6s9cfje5NPmhI4O+KwuY6IcMyxZaCyqx7j9c4qSioP
	 OAKk/bsalY9UzMOpoDtRNgs7zxeonG6gVg0PFUhg1NfkxFPP52f8PYIq8by1+pxwKhtiK
	 ZPVAmA7FiY3/CQvyNrsVR0B8qJHWTDKygcAoEqVXlFJvpRx8Fjx19eV4hGjhvTEI7CwXk
	 jHKJrgm9pBAjdhdnUaG3KwvtN1nZVJG6pHPYvaNK2e8TRE8ZhNqCvKaBvA9NuzZXj8Piz
	 jIvHAuyzFaX9if9qcTFKMZ5Ibsjtug7mBxbRkDfRynppWjIWZ9tWTxO+tMBWD/7FksQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985306;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=mzPETPHnkYVK0UfJpNaFhQVJoXImwU21czXLXkKClNk=;
	b=mTt+7W1GoYgu1SmBrJPlRe21MHl75n5aeu5fe3J0JddqfJXYmCQGb3PTG50i2f5WNv6V
	 WZVrHM8wwQp6WcpGrC7aZlQRIflv7ucHEIWKChbdPJihcU1TO2kaHA2Kx88OSR3auN8pk
	 Ee2Bz0xRg1X29A/7I1ILblmAgGDR3nMGVwOO8oBWbcMfj9M5ZQBgSJzMdjRtuO+C00gSs
	 FGW4bSlURCzSe4evRA0jZ5/uMrDSaunfXcXJHAmyeu0/Zgr4FuH5JMDot4Fn7Y84cw4Yu
	 mbc1p9voDrwS8rj3gamVONIqqqqnkByxpP0eB95AAffTcHUjsj7x8UZXFaXPPP+edRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WU1WEKau;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SYZBJm1T;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE39606A32C
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 17:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BE39606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WU1WEKau;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SYZBJm1T
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Exw1n2670638
	for <iommu@lists.linux.dev>; Fri, 6 Nov 2026 17:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mzPETPHnkYVK0UfJpNaFhQ
	VJoXImwU21czXLXkKClNk=; b=WU1WEKau5zQSj+GfaHdAlAwBxl+uKl+Xc/Ixwj
	hJ1gFD3A60RZoELqBS7gKmcYPwyRmm1VbfXfxX/b4nW3DQx+f+P19s5XDGoFG+RX
	sSDNky0Fw1gn3yJnMZzn2Y9tCe055TXZTU6lfSETCxL9EiLfK4JpRaOOET+llHq7
	HHJ3W4NQ4snARMyhFqDLzZ6L1Snplds1Zhwd23BeruhorgqCjIzeFAW0DU5Wp3IC
	8/o9P2V0ry1EyAvj+ZuAj5kPvE3zzYGQ3r7FlLBZCtJc76Qhwb69Z088/X72yYDt
	GV6K9jfDji8WKw3bMkCAXcGb6ki/WHvclFsl7yj17H+GsN0A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pcbuan-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 17:15:04 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36ecd5db581so2699166eec.0
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 09:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793985304; x=1794590104; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mzPETPHnkYVK0UfJpNaFhQVJoXImwU21czXLXkKClNk=;
        b=SYZBJm1ThtpgH2CITBIfi8j8dsDqeXOEAGY7o6WRLIcayIUHKusHFmR0INV9SB7bqB
         FLJLBvIo1Y8MpoqKTIiFwkWfVccye8hih5CKL/vReTDS0m05Cd/5to3fG11DmB1zw7/B
         DPbqof+dnA1OASM44wa/NqD+9lARj4G2Sp+Aa1vteucDNt5HJrh33gKCSe9vcaBtJu5i
         rckCczJd0c83v7r+zYb7owAlHR/zH6Mfo96WLEr+ZRq24fE+x8ZnidyqWwwIlSbT5nO+
         jr7TSz2xABIDg4RIGU1x19VsOLPhz9iOJGQ30J7RSEnWRYhr2KHjqQ3C7sLyHqJb84mA
         RbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985304; x=1794590104;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mzPETPHnkYVK0UfJpNaFhQVJoXImwU21czXLXkKClNk=;
        b=nF2V+kIq9hsZK4aYfrkDuYoEK7xbv5C+arxRqyANujlVygtf/NPu1vL77DlXN9Ah6O
         3sE28BguN4qUAwKcANcw/E7KdDMdQXEklaejCir02ejyIPqbcC3gVwGljGzjIjfOmvFs
         V4MjlSZSkxVA17B+mu3BTzRdKRxWl5Rxfndnoj83UsCSnU/oLaUs3tzY6y47B9zP5NA3
         HHHaYW+Xz51yDxwOFvNTR/p+WIPJJs/0qxpRIAggg93log3US2MEJLsqn9mWyUUiFCAX
         gO6VuzzpQpnGwsxW24EoLsObOzX79vHta8JOfzjoAjimL5T3uUMmHa+VP08CW9tHxTE1
         rX4A==
X-Gm-Message-State: APuU4Z9FiusghFc01KG1aa/dzBQbCenhjQmdjRG86PNt+aGfCWIEF+Wa
	2Ez/ATgXgKclpA6S2fN2buQ5YFk4yQE89CQitP3nm1+zNIlFFzS1gLB8rxDXt/1M90FUIkYvz9L
	CwV3Wep4Ds5GMcEkYjc8+ljGcEmenjDL7McCsU3u1ghl9efpIT2nsyPAIYQ==
X-Gm-Gg: AYBFou04KDwacRdTLnFScsBfTAVbzWSqhERqq2eNJuNrW+HO5OWZWEz8N1sbOHv29tj
	lxZum9XERJkj5/EVgpwoxox7+kJ4djoU3ZAbj+r5fziRIe6wR+lkMFudHQmKNaJ5wPFw4Cne9bk
	b27w/vTDj/QR105ogtnsDLVcr6bN4oyxSsgn32ZqHhaMhtm2H+5C1o0noFHCk55PuxE4LE5WbS8
	VNDeBRvyU5sVhdlkvkSAEONWPOIT3YL9/xO7k7MVusTbevwCtAvq4Zex4HNwDmiGdXCjtW71iu5
	d0i5z/hx4qRMDa+5z+OMaMFAPyyBoiK8T68iheP29gusf6NI6COz3oy0akrXUYUyFLFalPorimo
	fKn8FRDpZccKHmN6ZEk/7/6tBxB6Y1W0eb90dIfayxOUYNkgczpawwvCaHrTSEYVxotYvF2gzL5
	x5Ka9RMzjW
X-Received: by 2002:a05:7300:dd05:b0:36a:f99:ae79 with SMTP id 5a478bee46e88-36f75a2aeadmr4180208eec.7.1793985303546;
        Fri, 06 Nov 2026 09:15:03 -0800 (PST)
X-Received: by 2002:a05:7300:dd05:b0:36a:f99:ae79 with SMTP id 5a478bee46e88-36f75a2aeadmr4180176eec.7.1793985303019;
        Fri, 06 Nov 2026 09:15:03 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm14693756eec.15.2026.11.06.09.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:15:02 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Subject: [PATCH v7 0/5] of_iommu: add support for "iommu-ranges"
Date: Fri, 06 Nov 2026 22:44:23 +0530
Message-Id: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAO8K7moC/32NWw6CMBBFt0Lm25I+tAhf7sMQUmkrkwjVjjQaw
 t4tLMCfSc7cO2cWIBfRETTFAtElJAxThupQQD+Y6e4Y2swgudRCcMWMtR2GcZy7uMXETse698r
 f+FlXkM+e0Xn87Mprm3lAeof43T8kvW3/yJJmnCktvKqlMEKpSyAqX7N59LlW5gHtuq4/RAXNn
 rcAAAA=
X-Change-ID: 20261103-add_iommu_ranges-549cf3fb0867
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793985294; l=2711;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=Z5Ua5oBOiMcZbFYp3oCu5cR6YJYcm7KwL8DCEcA6yZU=;
 b=dLAbyFhw5znL5UwjVUjewzKHN9IhmK8lt4IzRQsAfxEF+wfeGjBKMi7gA6LhDWlqg/7I8BhFy
 kyP382eR98EAPvFVqWUFsb0MnYZTmNPIE/Wqrf6JXkgZiv/PbKP1CNB
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-ORIG-GUID: FpM_WkkHaMyGsne4HqJeRpcsjl2qKGEu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX8Q6C+QRDF5tp
 daJoPr7k0ONp11iYJ8PgiyWoL80NDVnT+iD5jVoJeco0XE0Xir2vo3g4qHrPG2doNumWUbGpQfn
 ufI+3/p7tPsmsLGBiwiORYAPoyYV0CaRwnvz+enOmFRES5hxTPljGQHv+U8hMju0i1IJtT7GK/2
 JWZpNlWULZ15V/l1VFBX8uHXeJDr4XYnRwEw5eb9InAwhNYJjNjayl6h20vOEKfSLDiS3UgQbuT
 rr9SQMfH5Z6IK9zXwtjNxYMtKmZ58bgUEmi9Qbz38T83s+koMvVlpgS3aMXKuOCebGmOQzWFQss
 0t0Bb6KNeuvAsB8vvOlu/zKTaG1FSve0VRGB8KQIpElCcFhdlFw2NLuJS++DU6L5aYqIrBfyYhr
 k4K/XToLRD3mBVDZO9jI6Omgfi937rocvEsp8wt/Rd3seX1b4ztXyXpw3KgmFa/0/aZXE5W0KtL
 6z9aHd1UmBkR1TiABug==
X-Proofpoint-GUID: FpM_WkkHaMyGsne4HqJeRpcsjl2qKGEu
X-Authority-Analysis: v=2.4 cv=TI3Q2Fla c=1 sm=1 tr=0 ts=6aee0b18 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=izMSoC9YYMgMvuwp5ZsA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX5hBIKsjt5/Q4
 t2O3OePVEFZPjsrVdrze7q4Q7vaAT7WWOwRczAH7B+a9zc+amQ5PpZQdJA/8f5eGtD4qnqH1hP5
 fvNA2MEblS+kZ7tuRmX8et0ST2OT4l8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060068

The series adds support for recently introduced property 
"iommu-ranges". It adds the required checks to error out for cases 
which are not following the schema definition.

Iommu-ranges was defined in schema with this PR
https://github.com/devicetree-org/dt-schema/pull/207

The patch series is being posted as revision v6, since the patches 
were initially part of the media series [1]. The patches are moved out 
to get review comments from iommu reviewers, which was otherwise looking 
as a media series. Happy to move this back to media series if anyone have 
any concerns. 
[1] 
https://lore.kernel.org/linux-media/20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com/

Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
Changes in v7:
- Move the "iommu-addresses" behaviour change ("reg" required, non-direct
  mappings rejected) into its own patch before the iommu-ranges patch (Bryan)
- Make OF_IOMMU depend on OF_ADDRESS and drop the #if guards (Rob)
- Use resource_size_t for the size in vfio_find_dma() (Sashiko)
- End the derived trailing reserved region at PHYS_ADDR_MAX - 1 to avoid
  overflow (Sashiko)
- Add a dma-iommu fix to protect the IOVA rbtree anchor on 32-bit with
  64-bit dma_addr_t (Sashiko)
- Use the "iommu/of:" prefix and fix the subject case
- Link to v6: https://lore.kernel.org/r/20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com

Changes in v6:
- Addressed sashiko comments.
- Addressed comment from Bryan.
- Link to v5: https://lore.kernel.org/all/20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com/

---
Vikash Garodia (5):
      iommu/dma: Keep reserved regions below the IOVA rbtree anchor
      iommu: Use resource_size_t for reserved region length
      iommu/of: Make OF_IOMMU depend on OF_ADDRESS
      iommu/of: Require reg for iommu-addresses
      iommu/of: Add support for "iommu-ranges" on a device node

 drivers/iommu/Kconfig           |   2 +-
 drivers/iommu/amd/iommu.c       |   2 +-
 drivers/iommu/dma-iommu.c       |  32 +++++----
 drivers/iommu/intel/iommu.c     |   2 +-
 drivers/iommu/iommu.c           |   2 +-
 drivers/iommu/of_iommu.c        | 147 ++++++++++++++++++++++++++++++++++------
 drivers/iommu/virtio-iommu.c    |   2 +-
 drivers/of/address.c            |   2 +-
 drivers/vfio/vfio_iommu_type1.c |   2 +-
 include/linux/iommu.h           |   4 +-
 include/linux/of_address.h      |   2 +-
 11 files changed, 155 insertions(+), 44 deletions(-)
---
base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
change-id: 20261103-add_iommu_ranges-549cf3fb0867

Best regards,
-- 
Vikash Garodia <vikash.garodia@oss.qualcomm.com>

