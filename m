Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B42352022
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352631; cv=none; b=UzFTQECvc5dRYR4y58iBONigTaGsKhCEvvjc+fa1O784P4sTL0Pxp+JZkoo2fGRqT/JYfFaCoOoT+C9QVC/q7QLyA8ld26L2y717ypVsA8WbA/PZ4Anam+FU20AEoViAzXl6emq70nVGzKNLZg8oSxNR2AwLk9KqQEBebcyItss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352631; c=relaxed/simple;
	bh=D3r2n74KWxEYfDl8rWFGKV6Wr7M1gfnVPwg1g1CrN84=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qibsM4sSYZbGUakqzPLir8vYo4vuhg+yHx5e5SXgc6iPdeT5bTgpTGyjn8NFHaey7776KZb3DhoW8zfmG6heot09YnJKH3W8EOGK3keI39swcmsFI/Cnjf6BiniKyJWNNFcn9otCDvWAcyL8jC49y2H9ojqNYoaOVowNHmCs4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Trw38hpF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gQ52Ol3d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Trw38hpF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gQ52Ol3d"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L1PSRY748681
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=El4wNMt9BXL9CxxtRdtqTV
	x+E6o7UHeoj7av7h+WfcI=; b=Trw38hpFc3Uxmsxjfu7cVuCmyXS6WZ39nWg0SE
	akyGensBif0/ULxQcPPBG9D7sac9jKuydsTJ4IaHQocxwctnByVKYnVB4mI0toNE
	SdpfJT9vOELGFzPNl9Az6o/kqZ08mXro8GaeDySwzyoNKFVZCLVkIYOnFsEo6KEF
	bJmt1M7ivhKwT6Vb+fDulepmbjEGwXUo82NblLrvbrDD/5b0quMl/RUmd/yH53xR
	P155WhEBw0FDk+ct73qt9Z1seTGTUP5Y4mlWPMO5mjtd4NasLjoDXfKeTfgsUzjo
	9Obr2KNaswV3iLrbA/+wijZcq69LTkyX7fshpsA/vGZdUnnA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9fb6kj2y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 08:37:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5165d10e036so83045021cf.3
        for <iommu@lists.linux.dev>; Thu, 21 May 2026 01:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352627; x=1779957427; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=El4wNMt9BXL9CxxtRdtqTVx+E6o7UHeoj7av7h+WfcI=;
        b=gQ52Ol3dBMOEycoEq2XanpnUAL1TU6qcNmpO+pXe69ntNX99KOr+j7c9lNYZy062WC
         Am81IBe/isgOHHuF8KcyR7Jg4NcDTquhqHtl/6vowh9h+ariomNnQiX3m/mrggJ/neIB
         ddloG0C8BQvIZ8Yf+clyMhGZuddhUP/XJJvMGUpW2g3dPYARZa0YuW1Bh4Je9LNONkEG
         1JirXetrAwRzFfoMBl2K2B4Ko4sQdFvC3m7jzu4M0StCFD9JfpJZOJ5ePv+3Nyc0NWuS
         hk+wUIZe1euVNSYXwucDtdBUl9v77eBcLDDhFFr4Ld+gyPknO1tc5I2B6YI4kg09vrkK
         hL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352627; x=1779957427;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=El4wNMt9BXL9CxxtRdtqTVx+E6o7UHeoj7av7h+WfcI=;
        b=gnCNv8xJeRMjg0D+eBGbJiQ0FcM5ZBAD0KzNAfOIJnArVvBi1aVVdYKakF2m1Dm1Hf
         gzz/qGYmA0TtNI7n985kHyIOeq2NFjojyEAJ3LvBOCNbywCJX+awWhPp9d4P5WHrBKGa
         LAoFgiT/HPXKm7gCGhAuIXISjAOm12UjJTXOkdLnwFObyYXYBL9fw7dYqa9Et7V9Ncux
         Fiwh6AQCYfdPvqx0EUcISUyV8MHsBynO7Ey8bPm0UZ2GxsJgucQwM7K2Bn1gB16xjp1/
         7OsM0C21l16jDh66yHx3tIyBO2rFqzzoLwsgII91fnGQx80jVuu1a28KtlD8vPtOfXZG
         mrmQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rOQjU8Kv92iaLidsZSmo0d1WqaWFfe1bhfeJJblqNaJKELAYMP4PbI4H3BfXTnVI4xWzdcA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4Zh6+zSEINVGNR442mCtvdXqAp+gIPkjySbcGLGOhh0DQt+8C
	TeB80QQmcTQ/yatQ/XAL2NrXFG2OPjacsqOHkwTyNOGaDBtmD25o7qno1m7XwEr9fYVab14VlnC
	LkIitUnZIKC07lFnJOOin6pBE3S+vsxSlGZaQK6pIk9Q+LcQ9PFgEQvR9gQ==
X-Gm-Gg: Acq92OEjOsV/XWDi0bHM3gkG/YfQItmQF/kguuQWZmivNWz70AZ0y1gdubB86SgwLcF
	982q+m4136nh1nawGGYwVp4o9Bbm7xZEcHpibtxqvouEMEyUzvOML0jKnjQ77vQHgy3EdrP6ksx
	8IiKEyVXgXl1B2FLkgT5y/8EDWIxHR32/uVuWzaoyxeJGDoJezFDI+KqvzryW+01M4ckD0uGBrf
	pNPQpzxAr1+PA29Htb4dCdMUxvx1MPAbLN7H1rkWPSkZkhq2gMKyZ8yRvttOK2DaxEuDfsjhSoh
	AR1ktYeKoUhM/ACk279uRrSNhRuzFJ6ybQQ4fKPcN/lhTSg1o+e5RpOCF+xyfa3/Uc45QqBWdi8
	C6mDYa6zuSEhnpmFkbbcpsiubY8Q8wQ0TxqE2ySTgPD2o6Ef8L8r5puiKY2MOqA==
X-Received: by 2002:a05:622a:514:b0:50d:900e:c1c1 with SMTP id d75a77b69052e-516c5484841mr24415801cf.7.1779352627430;
        Thu, 21 May 2026 01:37:07 -0700 (PDT)
X-Received: by 2002:a05:622a:514:b0:50d:900e:c1c1 with SMTP id d75a77b69052e-516c5484841mr24415481cf.7.1779352626922;
        Thu, 21 May 2026 01:37:06 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:06 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 00/23] driver core: count references of the platform
 device's fwnode, not OF node
Date: Thu, 21 May 2026 10:36:23 +0200
Message-Id: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAfEDmoC/x2MQQqAIBAAvyJ7bkGNzPpKdKjcai8qChZEf086z
 sDMA5kSU4ZRPJCocObgK6hGwHYu/iBkVxm01EZ2WmJ0VHC/fHCEiXZ01vS2NUOvaIVaxSr5/o/
 T/L4fVuIfJWEAAAA=
X-Change-ID: 20260520-pdev-fwnode-ref-d867836971eb
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5107;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=D3r2n74KWxEYfDl8rWFGKV6Wr7M1gfnVPwg1g1CrN84=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQZF3+Wnnqse1OrX9tW8YslypJ8/2vlajEr3
 JD2ATbv3b6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EGQAKCRAFnS7L/zaE
 w8EKD/9dgPJ3F9RbNULXnoMj4pWPfWo/PfTbl87hUlFmLRa5e+BZbCj7lym0G7cDSCBBxhP1m38
 XDMPAP0b7y/NNBM5+VFFKiHSXL2ftnoZYhTiPCXqAg8yXpg2s9DUQx7N9NbBTjBZDPFloWIKRq+
 KlrMHuxSs7HgG8kOBSK5eW4l+mXcdX07ZoH1zm3uq+BtSWd3lpPf2/lLKF+k5Cc1lpzbfNDEq7Z
 Ykm7Kfr1bDflSUQG/fhL8ilD15sZF0ffqDCywGL+UWcM5riCnkN5/v/BOF94pxi6LYD1XBlKs9t
 9gnTDKdlCmzmuhXIMsvOdZbSYYaJdad0De3ClLQ1TJN9KZXrqkxtJmLL2WUv2kI+YgHoNhRxM/d
 DoZ7lw/sbJRbjlusrb2aLa4FDl776mKWYhsIxGgIm/BEQk8ttADCJ+lCw5QMO0KC5BvtqRFoazO
 pG82IvBTgo1DqWURzhU8JiJIsRJMdzSm/fNAHAdK3htZj4WBovzhar44MI2zYLwsIEOTWII1a/C
 zWJCChwoCsQXVVI4H2ICRncw83pF/8yG5ToHIO30PdXPpkq36sYUdxvG/qk/pmu07MX2Gz3GGPd
 4HA7SKpoUAI1k/yCQzarBy1I3uysZITHV1i0mIHh5wtU/1mmf90cnXhXSuAnrIq3vTxq48wjVLg
 wrYHri/y1wYzsQQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=do/rzVg4 c=1 sm=1 tr=0 ts=6a0ec434 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=x7ldU9BvHY0adF9BoRAA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: TWfS2VR3YO5m43QFKuAKEGr5R0yCXQk5
X-Proofpoint-GUID: TWfS2VR3YO5m43QFKuAKEGr5R0yCXQk5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX3eJVZ5UfOdpv
 OosevdMhbFNEjdO0xnOMFr9B+apUmhg6Qwr3mRr3vyNU4ssn/LsAwDd40c7qhy4WJ2VfifWX44M
 wBRMcPFsGVBoWPkY+uidzUeGkSFxQKJ2QFg50N6pv1cEx3Q0iO1AfulMxywUWQTANm0ZQluMpRr
 VDAzklgkVfXMEfMFGP2ZtxSx7yY7Jp+Ef/2hYxeCmyFKqStCLLumplcGy6tKz2cLQMy6T36l063
 O64WsNnagojZOzgs+gBBmSH3mO8clkFghvWJkgkvFugEchP8j5fOsqWPwmZjhi0sPvmRUUWoouO
 qQg8rmGM5mUS3FpRrq1/ZVukfqUw4d+BwjIxC5KgXdXhnL5SVkM7hPppNZWNAnyjIAlOzmw7x8s
 iINxYQcaKgiXCGLrC5qIDLitjoB1MWxGrGwAbt+jgSS/1PskAKjXSJLKZKM8mujkzzsgfPba5Gr
 7hfnFFztQJ0RwWmwyPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1011
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083

I'd like to first apologize for the long, treewide series and an
extensive Cc list but I think it's important to show the big picture and
the end result of this rework.

Platform device core provides helper interfaces for dealing with
dynamically created platform devices. Most users should use
platform_device_register_full() which encapsulates most of the
operations but some modules will want to use the split approach of
calling platform_device_alloc() + platform_device_add() separately for
various reasons.

With many platform devices now using dynamic software nodes as their
primary firmware nodes and with the platform device interface being
extended to also better cover the use-cases of secondary software nodes,
I believe it makes sense to switch to counting the references of all
kinds of firmware nodes.

To that end, I identified all users of platform_device_alloc() that also
assign dev.of_node or dev.fwnode manually. I noticed five cases where
the references are not increased as they should (patches 1-5 fix these
users) and provided three new functions in platform_device.h that now
become the preferred interfaces for assigning firmware nodes to dynamic
platform devices (in line with platform_device_add_data(),
platform_device_add_resources(), etc.). The bulk of the patches in this
series are small driver conversions to port all users to going through
the new functions that now encapsulate the refcount logic. With that
done, the final patch seamlessly switches to counting the references of
all firmware node types.

This effort is prerequisite of removing platform_device_release_full()
and unifying the release path for dynamic platform devices using
unmanaged software nodes.

Merging strategy: First tree patches should go directly into individual
maintainers' trees and land in v7.1 and stable as bug fixes. The
remaining patches touch lots of drivers but the changes are minimal and
unlikely to cause any conflicts. I believe they should be queued in the
driver core tree for v7.2 (possibly on an immutable branch for others to
merge into their trees). If the subsystem maintainers object, the
alternative is to queue the three new helpers for platform devices via
the driver core tree. After v7.2-rc1, I'd resend individual driver
patches to appropriate maintainers and once they're upstream, we can
apply the final platform device change. However this would take three
cycles to complete so my preference is the former solution.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Bartosz Golaszewski (23):
      mfd: tps6586x: fix OF node refcount
      net: mv643xx: fix OF node refcount
      slimbus: qcom-ngd-ctrl: fix OF node refcount
      pmdomain: imx: fix OF node refcount
      powerpc/powermac: fix OF node refcount
      driver core: platform: provide platform_device_set_of_node()
      driver core: platform: provide platform_device_set_fwnode()
      driver core: platform: provide platform_device_set_of_node_from_dev()
      of: platform: use platform_device_set_of_node()
      powerpc/powermac: use platform_device_set_of_node()
      i2c: pxa-pci: use platform_device_set_of_node()
      iommu/fsl: use platform_device_set_of_node()
      net: bcmgenet: use platform_device_set_of_node()
      pmdomain: imx: use platform_device_set_of_node()
      mfd: tps6586: use platform_device_set_of_node()
      slimbus: qcom-ngd-ctrl: use platform_device_set_of_node()
      net: mv643xx: use platform_device_set_of_node()
      drm/xe/i2c: use platform_device_set_fwnode()
      platform/surface: gpe: use platform_device_set_fwnode()
      usb: chipidea: use platform_device_set_of_node_from_dev()
      usb: musb: use platform_device_set_of_node_from_dev()
      reset: rzg2l: use platform_device_set_of_node_from_dev()
      driver core: platform: count references to all kinds of firmware nodes

 arch/powerpc/platforms/powermac/low_i2c.c    |  2 +-
 drivers/base/platform.c                      | 56 ++++++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_i2c.c                  |  2 +-
 drivers/i2c/busses/i2c-pxa-pci.c             |  3 +-
 drivers/iommu/fsl_pamu.c                     |  7 ++--
 drivers/mfd/tps6586x.c                       |  2 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 10 +++--
 drivers/net/ethernet/marvell/mv643xx_eth.c   |  2 +-
 drivers/of/platform.c                        |  2 +-
 drivers/platform/surface/surface_gpe.c       |  2 +-
 drivers/pmdomain/imx/gpc.c                   |  3 +-
 drivers/reset/reset-rzg2l-usbphy-ctrl.c      |  2 +-
 drivers/slimbus/qcom-ngd-ctrl.c              |  2 +-
 drivers/usb/chipidea/core.c                  |  2 +-
 drivers/usb/musb/jz4740.c                    |  2 +-
 include/linux/platform_device.h              |  8 ++++
 16 files changed, 84 insertions(+), 23 deletions(-)
---
base-commit: 687da68900cd1a46549f7d9430c7d40346cb86a0
change-id: 20260520-pdev-fwnode-ref-d867836971eb

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

