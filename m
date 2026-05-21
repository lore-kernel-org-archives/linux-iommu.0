Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3203B1018
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352674; cv=none; b=GgUX96YJeSpcy9i7YLKZiBvZw/CftoeXM6NuwDehec8zb8HV1XXV0m95ss6Go/ASbSM2hxQo3TEZR6JZVO2WfoTkiGcp1YMz9s3HQ8a4G517x62TxI+2Y5o66RAi8NaNX5VSI2ArzPB9anR4gk6hCZKxH+xgodESjAU6nJ3vIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352674; c=relaxed/simple;
	bh=62Oz1SbeAMwV4fv895oAqyFh69nhboZTNIz+xPLsUyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QeIRDyK67+xtwWqMpbrUVDgB8208veBbZIm2TnNonvPLAvjbf/Pl/qP7ZSvqbhy/izas0hdBd79/rax7QbqAqtY/NOehJu33cTOt6Al0aKot2zCeBzi50iPh39EOenEk0j8yHPFCZz4faUy+NyReWJ50t9FLlW+uCvUa+f7UxLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wx0mkrfh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YakUfsgv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wx0mkrfh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YakUfsgv"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L78mVH119131
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5cAewiO2Q2GR7KlmQQdZOQuEhoEBjBTz5dtw0Vf2kkM=; b=Wx0mkrfhTR25R2CR
	P19rj34FWn9V7nFvEfRskX2RWdvrWsW1njjrnxOrV/EhPy3AZr/lBeiimxCLDs+u
	IvefMDwBXsucLiZrWeC3atAcK7tXPEKVXMmJ4Nu/9snsAU+7uZdGmON+ofOmgpK0
	WO1RCTJ11flpN+fzXzevrwr/Z3XDSRoOkYyINb6plIMdZqx3juYxIFE/7fD6O4KK
	r+8sRezB6kVXkXTd2sh7wG3GEfPxaiqpsX2h9VwexfrfY1lrJ2CU6NL6wHOIZbRd
	3u8kPyV7Qyk2R2UHNkvKTnwsaZCdUtQLADvT9TPpntLC8xoYJj9rguVoTpLjy3Ff
	Aza/Ug==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee8c1ap-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:37:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50e423a05c8so160878981cf.0
        for <iommu@lists.linux.dev>; Thu, 21 May 2026 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352655; x=1779957455; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cAewiO2Q2GR7KlmQQdZOQuEhoEBjBTz5dtw0Vf2kkM=;
        b=YakUfsgv9nVCcTcPij0FJdz+JWmdEaNu7t3VO3Hgkk5SPExe8MgzvM9Czr7GeCSx9l
         M/awA6w60FubLDtkDh0FMMeEhJfUG5DYLNwJzaWsRDYxCL0mGMIcLGnsDSyzstNy/aba
         f011E4d20DhGX4R23UaQAuXavKjqVCP42ApJJqqbhurZtVsnJxD7ll7qtRWmQKqzTe2u
         fIcNWTdxT+PRwHkVm8fT8QkEOqNIprD17rd0UVjROtcRKLQUAT/j+gsa5+sTGCGm+426
         pnZ50pBJ5dlAZl6nvcgSC8Rfp2ClUSp1E2Drp3OoO3lP6HEaLfjFjA4AsKGxBExTWwJ5
         vr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352655; x=1779957455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5cAewiO2Q2GR7KlmQQdZOQuEhoEBjBTz5dtw0Vf2kkM=;
        b=A1UL8btY7o4NRvCfeHOJ+UOTaDeiI5rXnbQoyZDZ/WOqzBi5tvTZrHi8itbkR4IwDw
         VHvlrozcgXPA1vcihr1cUbgloeHGmmTU6L0tlN3ZbBj7eIrp/puAUks1d5Qi0Fr/kzOY
         svHYtTCLVya5CbVbf06mAz8JQhBKQPdtA7F93UdrNI8CFR85K0FIlcD/htoDdcNQS8Uu
         u3vyIxNWD3i4/bR77ngVT341oq3UM+Q2qhCa8qQiI8lj/ruXW3TJa83XriTnp+ezst5Y
         ZSgJNX7kiLfdNFo6E3Cly+zeqrmagAD+SGrF5MJFk0tamTv3IFVKtgqvvlLRHTEfHN40
         ei1A==
X-Forwarded-Encrypted: i=1; AFNElJ+XVgWPMjEN6xcfujT+fCGYD2ZXZRqg1nyKHxs4KaCS/SjQsjayay4WBoVAgdXjCmEjW8vfzg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1+UsC3xN5yg28C7kzC4z0aPy+n3C0OyJMRB7NTgDJQvBzmemY
	ufODV1k/WeaFrgogg8RqSFADrNWqY/NZNofO/1pXOhGwfor4ky9O1VeCmmo1QH+JcBlMvgc+Ujq
	ZhyJjTunE79kxQyNhxNuaGgDnfeOTCH8XO29b7Fo/3riBsWWOqDQ+D9UVRg==
X-Gm-Gg: Acq92OFls/ZE5P2AW0oMuG4hlsmWdEmk+VQF4IeNvLUNhRkmX1IonOxdic+FAjL7gsr
	KbPQ2GvauYSjymP7J7+gQUo6bfVEHlmYpCsSUktYF5gUMGNsil0ae9v2Zzg0qU9c3lBZFNcDdKe
	AUBZndqhbdfDl/QneN7kBt0hDjH89n5BI2+bwGqGo+elnzp+A6BBVMtpOvzi/JWIetGn+CNfVxV
	M8S8AmQgA1yJr3wbI83QsMnkpmDyxxI4w9IfXAz77WZok4nMjU5ZMhcxCad51hnjZWo/sMDxUjo
	ucSTlIWkkJWJncq2DIvOiH3iYTjZ+XtpI1UoTA1US/brvJgqf5Ui8hnA24iLlNM16fEprehyKpf
	gvvyK0KdzXB62hZLmqrrNzEVtw7h8ychKZCCXvaqrnLswWPO9E6A=
X-Received: by 2002:a05:622a:558f:b0:516:cd8d:c7fa with SMTP id d75a77b69052e-516cd8dcb16mr1393021cf.39.1779352654842;
        Thu, 21 May 2026 01:37:34 -0700 (PDT)
X-Received: by 2002:a05:622a:558f:b0:516:cd8d:c7fa with SMTP id d75a77b69052e-516cd8dcb16mr1392831cf.39.1779352654276;
        Thu, 21 May 2026 01:37:34 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:33 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:32 +0200
Subject: [PATCH 09/23] of: platform: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-9-88c324a1b8d2@oss.qualcomm.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
In-Reply-To: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=877;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=62Oz1SbeAMwV4fv895oAqyFh69nhboZTNIz+xPLsUyA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQmchZFDFTztRU29nkcmIf2nW/nwlzDTpQz8
 +2keRMrA/6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EJgAKCRAFnS7L/zaE
 wxw/EACn8eHQOwjd+Dgeolnl1EcseWe/xGk5I4KpBP1p2m+G11f9vLsOUXBOPZGZSyzUPO47NAC
 iyozeeVO+OH2RpEvb/3X3MbeIb+N7xCFhIXoBy9dHt8TFTc2eZb0zdOcQaQ7HwDPqPAsbDyDPAa
 tScifI1XmoBcqV9V1S5KHZLhhWr1TPVqyUBvQJBVFTDr9Dgc4IxSYyYTSp4oxZAseFDlwBM3oMv
 trGKhh+xWYBpqycF8F3nEAvyJKUpMT1WskDUb1hehpfJpEVsb7kEOzTj7zGh9PP3osTLQB1dDAu
 k93V0oRYboHvSnoLrZOA0OfqTfGPC94giWuIlDQxQBJ1QYipOf/9/bJ8EwDeKu9NiKwsunEwdwv
 ZDsejl4PufjMEpJ7PptHLqO1X/ktVBTcRplnmlTo53Vs9em3L/5kSW//1XptpJg5MHQKstiGNhT
 JwXkhQKxsEWHTU8bBlJ/KnCl5YeVz4bAiwE5K3LMZGTXxaPrKNPQE2a7OgCcqKI7GJZN+MbaSR5
 iRRE4GsITdqUI+V0a9GmZFcR/ACxIhFigTivLDROyYp52uEEBqs41OjLaek/Tn/8+GAbu/+LBlq
 9u9KFLbmZmj68Q+6ZlZNIN+DZ4GjJ1qCQlnSFJk++NQiAZCIzxiS7FBUV7Sc4R1rjga7Eoru04k
 30fJtzl/FkuS5GA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: 8hMyPypZ3dsvjfxTmQ6l5vGiWFfalTTA
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0ec44f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Jb7EFCjKRuSTjX4XlnwA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX8hIRVDo6Msk2
 NKVkAlahI1BIwfSZekz5PCP+O/4F5eu4zd82rHRQLiIeU9rpdGBK+nLsNbYbCFiomQ+ACfOVuQv
 iZl2kQ8KAI5kZy8t9YEmRdjMXo6hQ1i/iwSj7CPeYyDh/T6p/g7piMNfIhxnzjl5IjJ3PEdtZ9w
 yupE0wPQBMb4PZfILk/QvVYulQ1q/Z36Xgu1eKYMHd/VLjNWlzu5XxXlLl93/+H8y9jVFE1J+Bj
 BUZUUsRgtZar3dNKpx6Dr9ho29TYlMBs2Aqm5yi0QBjzLT1EF06IDDQlKo4nJMawJfdua1UbgM3
 e4YeYK7Ph6uXsM9hyZ/V4Uv7oAp0T8R6dtT+/v3H72FwkoHc1rfZWwx65aLNlJw/RuV1WS7oDOu
 3L7gmsTy56whMtDLE8RSCslEnIDkMJYlIvRksWww0y++8VQf7ISN5vw0z3GXpsvwGSUIxL2L37o
 aCTIyX2KtmLKZlJv8kg==
X-Proofpoint-GUID: 8hMyPypZ3dsvjfxTmQ6l5vGiWFfalTTA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/of/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index a42224f9d1a888a6e6cad7534cd2c5f110e995da..db45d1e99bf9b027548aac3a15bf754b3c023161 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -126,7 +126,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	}
 
 	/* setup generic device info */
-	device_set_node(&dev->dev, of_fwnode_handle(of_node_get(np)));
+	platform_device_set_of_node(dev, np);
 	dev->dev.parent = parent ? : &platform_bus;
 
 	if (bus_id)

-- 
2.47.3

