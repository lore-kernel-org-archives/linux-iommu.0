Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504CD3D3D07
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539543; cv=none; b=kCzhmXomywfHXZAOEniBnDmVK5roUykGvqg10Bd7qYqF6t8va5B+GIDBqueNh4PyrrD71yNAHTzxMlxX0WPNFHFBA33ac7m4sh2Nh9Imv7ceFivMswAkt4dVOuOgSdOwyyRDTanZrcKq0v8Ze1t58tY/izQsBoMbvz89RolH1kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539543; c=relaxed/simple;
	bh=ngE1ViR1uejC9qMYv5QiOE7AeBgS+j6esA02JjCNPps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cl7r6kIHGeQX3nNDP7TKGcVJp1MBCL8nS3d0t4NmWMX4pqqaNVjXWhFCLYtSJLaVnac1aHNfoDrDI4kfJSSxj6oS/jPtMiRmodUnJXPIN4vmFywFMl5a1W5nagrpfur5uEmlEu3axAV/Yx6fLLDBvH6bUcesSbsIzM6lofEiTG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cdsk810P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cA27UAfo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cdsk810P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cA27UAfo"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K87WLe2000790
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 09:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UIZ+VAsVn1SNZ95QGAq5L0m52yqYtxRT1a/8J3q9Pu4=; b=cdsk810PBp7g+01t
	jtgsGaB6bqe7awz+CHFFzkkzoLRYq0k1QLv8MuSjFV4W5+7SdbFv/6T4M9/nmTqb
	9hSzA+WUDlYFsy43Oe2BJmMUGoCTsH/SbrIid3297qp8o4v+URjLubzvWI99IWpk
	bQBxqlqdsY65+HrEd87wxvATZbN4vLF86FWV2YI+1BWihFWMUsi++2WKU4Ew6MSG
	i3twBcvytFoyV5dmENS0paEGxzTC/InElCdcYbKTpIlG5PY1LYSoqfDZ3pI9zXzl
	thHjSjWosG9kmlp7yi+JysDF2XXnIdixKlp1Ltj19pyBdQ3sg6xMQVDoV7w9Y2Eh
	60oT1w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfvxgcuc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 09:25:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51bff5c7035so86656451cf.2
        for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 02:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784539535; x=1785144335; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UIZ+VAsVn1SNZ95QGAq5L0m52yqYtxRT1a/8J3q9Pu4=;
        b=cA27UAfo3Znb7HI98UcczjZSHm1sYdl7Id6je5inDCmbOEEeF+cht5ESuhVZjpCYZF
         bzCq0V9Xw6FQpB6IVjHL7y48P+1geZIn1HVsg8W/Sth9Iop9/qfp1+lmr9+NjXqWUh9L
         crdFQzv+vUwo5elSc80DZp2LBlkUhuKWxVj0Gnj/HOk1Kc7u8MCcH65w3/7fQ/Me5YdX
         KDqKceuzkrqgMam9+fH8GpYwBR0WWmFzsEL17Svyu2GpbADXrT/0ku3BHB5/mmU1T81q
         vMvOzQN5XZhLvTrCJlNMno0lhZfc0OMWWmosNjFeLoD+YWLOKHJomzzlOAHXO8wW6vOd
         8zXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539535; x=1785144335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UIZ+VAsVn1SNZ95QGAq5L0m52yqYtxRT1a/8J3q9Pu4=;
        b=VL14p8E/n114cH0ONZtp+4KOMW7CYHDFwYjpn0cF3DG1AS1oPOH9j83B6+nU+JSfJ9
         v2Qj6QUsjWZVGf6jf0caDEgpmTZUHywWDCuqeEBAmb1it7InVMglwd7Tzg89n6eVyhlu
         4QDO7chpSNc51jZ3wIlfGU/R3sD5i5b6E/UlifeWnhWaoEHt469JRvJ/mXpYwWMVuSV4
         uVTBqRRa/Zm7NQpxaqzqpLyI0P0MMBud8hzWtzfU3bFmAV/R7gX/OKAs+1pIzQx8d90S
         RQW7jpS4BCWPokUfnFktKyYQ8nvQP9TJ6L2hgPZsvLo16BBDxuCqX8+7bKCH3Mvss1+5
         V0Ag==
X-Forwarded-Encrypted: i=1; AHgh+RqE6GZChHC6L7a8sJGx/xmCmv/dA2QWfqzvVYwU+tKC179lu1n6EHZKKezWudziUJXcUw9A7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFIn+K2+3DP+dTD1iFQCsfnzaY6pbI6vLOmYmKpyG+1eDod7s2
	chkYow3sAI7kqUhP+VsDNT52alhtM4JjUMru/EubT3naPL/iXmHCY68CQXozeJwS8HaDGVUJMLl
	Ki/V2ivGfXIRorZS1PqBUSVVpgvMyUlE8epPJseMA5Q2MXqjXECHMTxEZNA==
X-Gm-Gg: AfdE7cnRZvhllR0mjJ7boA1wc+Y11gpHshKnFU3pnvKhtGFCUDlwDQttQj9kIouhbac
	BuPAA68N55rgW0ELQjUjk1Taw1wLx7UjLzaqL+9DiICTXygykI8A20pPrJofs6xyiYpqGMW7IsL
	9aolXGIPHucsSkRyevL1unh45Bg8UnqLOwoxvhlXHDK/MVFGhw1Ea5kHH9diOUm9f9XfOX+bGPz
	76o7yWM/husMT3ff/mrT9ECVuybvlL9f1G+aMDAKUyCh7fw4q/ZvQgSg3c4yBpAu3gwOhGeNxRc
	kUKsKOgA4P4QXr27Lza3GUKrrYPxG8Ll/HBenLokBASn/bsM0X9CpWiPf37WBUqS0zsKrPZZ1Ho
	C7/elC3BkB2Ps7onAnSZw93mp6AVkOA==
X-Received: by 2002:a05:622a:8405:20b0:521:8ef0:b4e0 with SMTP id d75a77b69052e-5218ef0b690mr68227411cf.17.1784539534900;
        Mon, 20 Jul 2026 02:25:34 -0700 (PDT)
X-Received: by 2002:a05:622a:8405:20b0:521:8ef0:b4e0 with SMTP id d75a77b69052e-5218ef0b690mr68227031cf.17.1784539534544;
        Mon, 20 Jul 2026 02:25:34 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:65fa:60cb:c205:d511])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955de88951sm62228205e9.3.2026.07.20.02.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:25:33 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:24:50 +0200
Subject: [PATCH 3/8] iommu/fsl: use platform_device_set_fwnode()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-pdev-set-fwnode-instead-of-of-node-v1-3-2dee93f42c54@oss.qualcomm.com>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>
Cc: brgl@kernel.org, driver-core@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, iommu@lists.linux.dev,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=800;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ngE1ViR1uejC9qMYv5QiOE7AeBgS+j6esA02JjCNPps=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqXel6iXQzzX/uv/M9gp2dgxe5JJKBdP3GI+hsF
 3nTXeFE5ueJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCal3pegAKCRAFnS7L/zaE
 wyjWD/9xXLl+a9ATQzUTmx2pnk3PM2p8fPrhJGmTlsNly3ZXJZphk+eDGVbTZjMKzCAO7n+1MYv
 KC3P5qWxuw82fl5Mbg02h92WwZFcK2jLnAt1fEaQoLmiwKYIglZlCzdDXqh8SF1Ko19OroltKBU
 jwvYBAr3Ie5QCwnDEs0RoHKKubZSQ5mouhqfRrd7qbgG+uDXDg5XpHtk0rDJ5FnPKp4X8W/XhTH
 3GweCttfjt4t/fiwM2j6KmWcSD5TJ+hjv/5KeJZf2QB1Eb0Dzv22Jvlb2raqCQJUCcCg4JAK5g3
 JCWI7Te3zkgFGiJSn9nc5Z9P+Qzwms6BXzpM3qfS5u/Ks7wgnRpq+urnXYHHPlZR64p/nNNQDkV
 xrsRgx0q3ZOgObWODPSBLq7wPynL4OPLsZv9GtIVxxegKpC4h/+4N/6JMo5EzkA79PuYLzxx6DJ
 pb+qZwcXPvSLXNg6IPVLewi3QQIB2HIny/YXxqUAipY98m3orYwhyp0sHs7WLviD4uxwrtAKbjX
 zyNGMpy9b7hxIWjIDa5PPa+q68hJILk4PDf6cQWZ5PiRB+ISL4CPpMGtkvCEcAEiVOQ+rhH2bPm
 DD2NrOLMt6pvLTRgLX3Vj54Vvcw3gI3OzMXg3zRQswULvjd4UuArBK9wB0sB4LT4S9trCF2QCem
 /w1WqggZz70S85g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=HKLz0Itv c=1 sm=1 tr=0 ts=6a5de98f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=le_mMX733WJEbBjyejwA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX7Xr32w6w50mv
 +Y0Z6E2ycM7tZK+tHwO92RX0daCM/j9A1ecKfbnS+2f405xur+xFM05WgLRDVRFJ0VZsqhr+QCZ
 8WWYq8FXkPNWNhsI+PfV0luSEFPkIuI=
X-Proofpoint-GUID: IbKp2BjYSdLglIx420QXDqtLCQ1431M2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfXxiMRVMXVRYe0
 JpuSB46hBxm8upLjMhQpSEFuV/tvG28W7Fwx4UmNGvo2FqF6lGaAjHFb+j9Ofnnz5Et5z+OmXhz
 IUQX4P/kXIGfN5fhmVDwN2xFFM765JIIMSluQcaT9oVFwjiSXIU/VjJ0qEZHqMCAq3KyWuKmgwq
 s+Ka1E43YqUb21pSdyqMM8JJIALc/9n1IYUyUkHn3IbkXLfQ4A6mD5yMNWwz+glpsDkbgLgwfbV
 QfSYqSJqsVNHyTStGmXCL+GEtUjbLe7vPUbCMh1dBnb/qrjhl35rGeVVKpSv2E/KxS4jIQWNUyJ
 XeA9lhFTTnHFIiS++kXOrI7892yUBX4+RKVqb8FuuBRJNfG3hMx7DwosFkXEP5Ar8XgAxmyXPAx
 AozwUIpeIt6+AF8z/NnEePGnmhYo2tzh5tHpFjBNNkbYfJnSV5JbyWWSBAzl1eh3Pybpc1c8V5G
 jlwXx7Sxb+tH7ArS2OQ==
X-Proofpoint-ORIG-GUID: IbKp2BjYSdLglIx420QXDqtLCQ1431M2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200104

Prefer the higher-level platform_device_set_fwnode() over the
OF-specific platform_device_set_of_node() for dynamically allocated
platform devices.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/iommu/fsl_pamu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index c83bbc3faad56d6ee1c89b0a7f74028af02c81e9..268a1f752fbceab4fd24013aeea5df1b6982fbb1 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -975,7 +975,7 @@ static __init int fsl_pamu_init(void)
 		goto error_device_alloc;
 	}
 
-	platform_device_set_of_node(pdev, np);
+	platform_device_set_fwnode(pdev, of_fwnode_handle(np));
 
 	ret = pamu_domain_init();
 	if (ret)

-- 
2.47.3

