Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C618438464
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341894; cv=none; b=oQtFxDD4I6V8ANJlyXWPDmIk9uPbLz9Nq51jBEVNl778E8fHk43MJ/tBBkbLKHDdOkJqIYhuiDE4UrvDaoCAuDxG6+bLNwjVP/C8uoR9XDk7OomZMnnHAqEyiQUxuk72jDJknoH40gDeamOHvY6QtwiRv7nAPzHdjW/wSLm08Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341894; c=relaxed/simple;
	bh=T44HwwZ1Q0M84+szoUbk3kJ64ZYTCT8dJmP8V7D67KU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hjj0sYvYWPh9gimtLYijw7zsTE8KJnRupKmTmPkBa/CarbY6MXd25ivLQN6xgmWLAGEwKtMD/RetA6z2R4vBZ9RzhzZoq1MCP45GWStsnnotehQeOocGwEX9ECuPGmrH/6wXCYSARhS4Hyw8aqBiDVKoh5xwn2OuYOOEH9xO6No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HvCI54HI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aWdReylc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HvCI54HI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aWdReylc"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxI4M391280
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 12:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7VfOweZR0NvzKfVRW7ae+/
	NW8JVQadN2E/hr03AdQ1s=; b=HvCI54HI6r2WAiPzYc0IXb/+6AOTqyJ2z1Q1Fs
	JNVh0m4mSZDL5o21i+i8bvQetkwOJ9innTRe2tVd0jSJc37bGA8wKzVwiVF7Bsus
	JGoJIYok+3i12s7ZIggCc4wl9NGo4bzR3lL/esbGOCJ8KivTwK6jzC/C+yIq0ptc
	itK7/HcU5/tl+x6Il+4JZw2JWuEe/WCA7wwlxVYvXsRwFcugg3Ha9ESH9WrPuh1A
	7d0ghGcy9nZhbdPx14EYgydrDsLFurGwhz8rQmkCylU0mnNOl87XtCbGrOKFBcW3
	VaMKUx2fmp4AnkeMMXbHq7C2lQVewhebNpZs8Kfu3Jnp69NA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgrrd4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 12:44:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e68cb7a3eso552979685a.2
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 05:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341890; x=1783946690; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7VfOweZR0NvzKfVRW7ae+/NW8JVQadN2E/hr03AdQ1s=;
        b=aWdReylcVtkBMx6WYKdGWrQ3wMwgb9jW8lgOwRjqH+S6uFlbnEFpeDAP9NFIH2tNKq
         68tz1mjAxMF67s3ybSsONUnCutbAzYU68ygn17ZTbVx0k2mnyifMYwd89hJbterZlGKS
         k0990Vcq+HhhtIoHfAhBCO2CrKEIHlk2Hi7AfhfB/NNrUWVXgaURbYugR56uwhgg3mEl
         f0Atmx5QqyG9aBeBWIZtBgAeMAbPRyQcdVi0tRGq83XrKImms5Y/KbBGI4FYgUuI8O+Q
         KpiIcxRlUSTqI9MScAQ4o+HTF9Cp2K3fFJSupZHLXrdFCXZo1s9lmSUh+ahp/MQH2PIo
         O4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341890; x=1783946690;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7VfOweZR0NvzKfVRW7ae+/NW8JVQadN2E/hr03AdQ1s=;
        b=Cpu3vnAfDMT1px54j/q5ADReBcB+0z8edQHGjJmE/tNntQLEnYk9LYrZuCNAuLGBOM
         z3c4FHS9gA+vD+qfy4PQYyqeN4f+/bXBCg9aT9MTeClAzOoVYMN199aay9q2vE2dY7y0
         04klDPXfmOoHiexRIrjXTA1OGD8xQVSjuvMefcHxgMERJXsTAwRUj6hsk39Rr/PbIZ8T
         VEuvX+LI8gG42LdyMf+QlhWjWXGk/zjda111BQqZAXlHoayGZse14swUI85lXk/7Weq7
         IwQ9OIhb6Y1aXmGzZ9XPGrqmz78+navBdqW8jGKJVqc67DzRhwT+0SPamUZdANCbVNn7
         8KAw==
X-Forwarded-Encrypted: i=1; AHgh+RpQadZCwp3eyh4qIlLTLG+ECUHCrjB/pmTW+tIWWNs83zPLUnZyblOeghvYLt/hgidPXFdsIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfBDc67QjvP7WhlWXCN2IM4mcpQMqMVEG6rM/ua/Laqxxd/MNZ
	upqCdE5l7FFt1vQRCa2qzd+us6HC4Rl+eNHVtIjYPsOImsfAlXHwAMvnsjpC3NAjiYXPgf/+UVA
	weXysp/xQ0XHeHKaYiXFJa7KsL2PSBl5NfYre42MTxxLWR+zfZfWt/r/1Kg==
X-Gm-Gg: AfdE7ckxGe4lR8+MjH+V7TWOGKRe46LPrmfYbYbiyOOLsiSQuXUQoERgZPt307fNdlH
	zX5qb/bTZCn9IehmzppL1n/L6oDfnGIZfVuMxWNw3fIdG0m6mjCbq6ykmFNRWESVbeGGjjz6j3B
	KZxYSq6fpDfu2sRuTCCV8IT0t1hHV3K6GgcdmSklZE1LQJ+L7ccV+UhpIn+bFTua1W+HKTeBwZj
	OfK9P79ONDu6jywtwqEojuKZm1PWPehrv0E4ueMm6gwRHqKiTv7OOIiTClbdUwlU9NeJn3KC/wi
	Is3u9KrnfODYHnw0a0lgynH13jhvoMQ4dtIq8AVjLppvMnFEx8limQB6uJruyFj2pr9gk0ADCn4
	XMa5AMpGr9yvQy8iCPCI56wvlO3j13o7jmqOl09jO
X-Received: by 2002:a05:620a:2911:b0:92b:81fb:87b7 with SMTP id af79cd13be357-92ebb4a74b1mr50553385a.13.1783341890099;
        Mon, 06 Jul 2026 05:44:50 -0700 (PDT)
X-Received: by 2002:a05:620a:2911:b0:92b:81fb:87b7 with SMTP id af79cd13be357-92ebb4a74b1mr50548185a.13.1783341889592;
        Mon, 06 Jul 2026 05:44:49 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:44:48 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v3 00/20] driver core: count references of the platform
 device's fwnode, not OF node
Date: Mon, 06 Jul 2026 14:44:12 +0200
Message-Id: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAByjS2oC/23NQQ6CMBAF0KuQri1pp1KKK+9hXBQ6SBOh2GrVE
 O5uITEucDPJ/8l/M5GA3mIgh2wiHqMN1g0piF1Gmk4PF6TWpEyAgWQFMDoajLR9Ds4g9dhSo2S
 phKxKjjVJqzGV9rWKp3PKnQ1359/rg8iX9mvxjRU5ZVSpRsBe81oZOLoQ8ttDXxvX93k6ZCEj/
 BgJ1ZaBhdE1QsFFW0n8w8zz/AGy8k9g/AAAAA==
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
        mfd@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org, Manuel Ebner <manuelebner@mailbox.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4776;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=T44HwwZ1Q0M84+szoUbk3kJ64ZYTCT8dJmP8V7D67KU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6MoJZpVWXquJPA86qFchcYH7k3Onxk1jGth8
 HC7/Ub3emyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujKAAKCRAFnS7L/zaE
 w5C6EACRXYySfkJXFyTq8zPf7US9VFpPW3RE274q/2YBjIesYwUF0YvCKdzVceLWeMMeG2J6zDW
 kKPnEeuZJw5iEdAZ/ZBRMOAmEubsTBD4+/6aCpJUokHzGF4atoDvN4qGLBs0yunKGDADXpORe53
 DKH2ZSJAeyeh6m6ApIS2kFEuxPAFgHOGRfJ49oU8HWhghwyrfZAafNM/pnRLdSVbJtjR4bbqJ6Y
 ADMhQbYObhQcUZPL+Pd0/zZ3eceBO5sR75HXI1CpMPtBmnurs5y8ROaFhD1O9fRw5R31AaggXa1
 T2PfA++SCs59XKUD9MZ+sbvqxbKl+eT1YDimp9jxs7EtpTwGbAhWKJQU1dnLAYH2DqJAyABQ2iD
 Jz+z/UKxaEuZta2/BUh9S+ltz05OQNOaGi4dnWyQZTjJOEOAndluZXURrk55+4Th+jZf/hivpZM
 PH3hYGyTBIsWD+3bwfWzc/ywqJmwpgf/lm6De13odOQ+CgbtKNhqj1YiAYm0ycwrxLOwiYpeFAh
 SafUvNI+inETJ5q/MDf2BgXJTLYnwwem1L9HjWvrd+KcxlyXvcNkU2NqjNIS+az2hgs6TyTwLj2
 6nrCsPnQJTSJQyRyLK9DlcWtWmfUmUcgkvKbl/Gtc3sMJFlfIjSQa2osUPg0ZgDKsosfSkNp2al
 Q5/taAz6caNJmuQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: Gd7Mbzw-3mK5KmVKpRDrewaksNU-oT9t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX4Kw6S0SbIDRz
 3H+K/CdS1ER6PWKLwW5ROMQ0mc74rksrY79SSwavlvexX/dmjfnfAA8IDbXyfwtOzc/YrXhw+Yk
 itJlrWdFGMJWmSUNuyjtbSDb1YH2ouUKxd7dTvNIu6didbg+0EhaXpcvwGAz3Pk7FDQ//gnAruz
 us0t0fxPAsij/+JFpYyIAdNdcbb2yGoDJyZQNsMmystlzM14/DJYqObv3zpQsg1BIXvWiMNy51F
 /mD7350bx5agEZCYkTARpYQqnzJn8beZSV8wzmcedAIOzCeDRMttCQElrgF8im3uI26uObKvgpL
 wsToNc4bhjYw99nI8zJbzEDH/jhfV29XvA1fyS2HZEHWdqHROgcrvRPzmnCr5YMJk9i5+3SF7jm
 0lKXF2SoAtjCU7yKhpSW1a4HHnl/KN7oKzkBcgKWFg7EuA+W3F0UZEZPr1OA3g4XoxuIMPIvb/Z
 1Lk8pbsh/wPDQM+/jOw==
X-Proofpoint-ORIG-GUID: Gd7Mbzw-3mK5KmVKpRDrewaksNU-oT9t
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX2h471YlG58nM
 wE/9AoGdRA/TyXdZfHQLcPiJ6zRWGLBgDMMoY2fvR+AbbewzjSzN58vT1txCkUEuHuvLxGK7ILe
 +m+ratNPcsVAFsHAb+XkBvMoxmpJ60A=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4ba343 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=rL0NY73m5x218zCt0XUA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060129

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

Merging strategy: The entire series should go through the driver core
tree, possibly with an immutable branch provided to solve any potential
conflicts though these are rather unlikely.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v3:
- Use device_set_node() where applicable
- Use __free(device_node) in fsl iommu driver
- Don't use __free() where not really required
- Add a patch updating the kerneldoc for platform_device_alloc()
- Collect more tags
- Link to v2: https://patch.msgid.link/20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com

Changes in v2:
- Rebased on top of v7.2-rc1, dropped applied patches, collected tags
- Link to v1: https://patch.msgid.link/20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com

---
Bartosz Golaszewski (20):
      powerpc/powermac: fix OF node refcount
      driver core: platform: provide platform_device_set_of_node()
      driver core: platform: provide platform_device_set_fwnode()
      driver core: platform: provide platform_device_set_of_node_from_dev()
      driver core: update kerneldoc for platform_device_alloc()
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
 drivers/base/platform.c                      | 61 ++++++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_i2c.c                  |  2 +-
 drivers/i2c/busses/i2c-pxa-pci.c             |  3 +-
 drivers/iommu/fsl_pamu.c                     | 16 +++-----
 drivers/mfd/tps6586x.c                       |  2 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c |  3 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c   |  2 +-
 drivers/of/platform.c                        |  2 +-
 drivers/platform/surface/surface_gpe.c       |  2 +-
 drivers/pmdomain/imx/gpc.c                   |  3 +-
 drivers/reset/reset-rzg2l-usbphy-ctrl.c      |  2 +-
 drivers/slimbus/qcom-ngd-ctrl.c              |  2 +-
 drivers/usb/chipidea/core.c                  |  2 +-
 drivers/usb/musb/jz4740.c                    |  2 +-
 include/linux/platform_device.h              |  9 ++++
 16 files changed, 88 insertions(+), 27 deletions(-)
---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260520-pdev-fwnode-ref-d867836971eb

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

