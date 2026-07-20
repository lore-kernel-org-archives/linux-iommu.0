Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B713D7D9C
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539551; cv=none; b=W1Opm/d7bXjEnDen+/9cnQvRqO98TrAMUh02Pz98upuyTH8xyDX1HDZWvX8CPsRQX2c/3MGEKrzPK6jSXOOgrtPPTe/b9Vrdj8ry43DY1ssZBpp1UvSqC5bVPwgTkLG4M+7cOpQxoXfmBNJm0ogh+0t86DUUB3x3ZP1/aMKv0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539551; c=relaxed/simple;
	bh=A6rTQywiVuri+akWPu8ZuzmrgFMwkmEBL5RABzyTsAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GaAVhVH+jn7DyyJAT4PIay94VeiAHS4MXceo5sByPtb4RxqJhd3KsQw6/CxbYV8nJXKMAw1Sj8PeCUhk/ygXTtNyDYWk5zvmXMS9z1dsUCCUmZLj5PAkmYikYrBqpOjonfF+dZHgLNSSy0lUUlw+UI2jLGs3tOZnRy/Jjzfzb3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jTX3r2ny; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZDyPUtIF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jTX3r2ny";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZDyPUtIF"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K7rc2P2979823
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 09:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	azoonAs2rZvyyYgYMRjUol9O+q8eXf7OwF52OR7cKds=; b=jTX3r2nyWsHMgzxn
	8FiVrwsN9vBocFeW49l7ldKA5XAZhAJvTnfLaGPyMqjBxsPnKZBOPmOYXmAuXLVY
	4sWAiXGaTX45boKk1A3m8XsO7Gmxi/ELddH67Z5gVDiX05ykqVAhWHKtR+3LGKie
	veQisNX1QTgE8ROX03T0wNSpfnKt6iykthul2wHTYqiKsUZQS+FSKYyXOCuBYwzx
	FP7tPplooLKcPdtEWKezKg9RXkJ/Rf/nlqNN+bdT6uAg8a8my1SerICuKrd5eD+U
	UQmT5/Vq/x0vfqtNbWmWRgO1GD1kO9nqhZUuC2tvSRXW5+IyGky9YO1InCixmuof
	tFEEDw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfpg0equ-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 09:25:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c083f1818so124833171cf.0
        for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 02:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784539547; x=1785144347; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=azoonAs2rZvyyYgYMRjUol9O+q8eXf7OwF52OR7cKds=;
        b=ZDyPUtIFWRv8aOHHGC7SfE1LPZIm5t2Si/AkVxPydUth7tpGGREN7awG2zUv5N5RBX
         1nImE8RPEw52gw26AYXr88mNYSe8Ux5dfXZbnFKvDwMhE2u8I51plhORNcVGMHBWUoJX
         4sxKWVh50CmlKn+rO9yC6zDtsF/9bj3qTnhTs43twp8VbBeG/P/T1uS6UEFvNLckjB+S
         BuMvMqwg9EQNkzetwEtwLcTtic12IrF4AUbu3T4OY2IeV4y3tgSdxpxjxdmJ766AoUqU
         LpzIlDdjlAbacSiFD5i9chroZl7hQtbICm8W+fUKjflXmxTwzOTVL35DogWviVjIy/zF
         gE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539547; x=1785144347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=azoonAs2rZvyyYgYMRjUol9O+q8eXf7OwF52OR7cKds=;
        b=l8byso0Epqg689AvyrA0qfQJfDrZJrVqpX6edE9wTnKXjsPQBrdDZTwaP/fB2I5j/9
         8WIPChcWHKph2187GNp52tZxe46Gws3QLdOq/yPAM/5+8kHxUK9y7yMsxiGMserxqnQc
         SucsqgPTFd6Q0Ow8izU8C0ateAAUR5E3rmRcRVW9bpQmeULss0imHBjhCuvNazZ+w7er
         NkeyYosKcZ/TX5pL6Ron3PQGGAlp9UbVY1/slBg1RPBrC2gclvaalFL0tGoWk8TRnUqc
         jesl6+ShWbu7BVNY4NDI43iAqv9ykcq7IvDuyyJzStG3bRsRka0fww6wL0aQKEruCP0U
         CKXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp8o6q3bnSFUL+Poz1AqWN+nt8uiwe/Yf92JnzrZ5u8BXf0QZVc/Ixk8stQqiD6lOCX5ZF7cg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4nMwg1fRj7yh90WwPL2fFIfqm/ZVUyYDZbtN7MUe0h5FLNpkp
	+s6i/XVFFqKC7NQhtia4O+zi606e8vnnbfH2WwF/qN/8sPFgwf5bEam+uvFV3scLz3FYK2PzW4U
	Wzk3Z2oFgbMTtfivOuP+KIbuY3ymONMW3xfxhjt3a/fQWwhDhfTsr0OWU1A==
X-Gm-Gg: AfdE7cmdb356iOOvDGkRM2Pr/swxWq6sZh7vgrrEBOIlEXuSQt7+fL2x72vE5Vx+FHf
	h4Uiau1xESEC2lxNyQvT4NOtH5sf8HDQLjScuS4YO3HJcRn0KbPsCexwt0rcanPBrpxNKUitl9O
	cRngX3VOzCo4fxBEToa6sc8sfuhYQRjhnkBaandbQ96mJxWxgKRAE30mhK8qprGQigzKYt53gB7
	5cBfL9BVpFwdJvYq0uijvqjmY+DQe4vrdijFpGk2TRpQscibGHwoZL8QHrf/XDkKGYKQw6tNtJB
	UfmH4b7c0nlRrQ7ba+4JoBNrnmPDb+LIMrtIeoXCZZghEmIoaeUooh7ZsorSlu5046Le+BlS4ua
	EyQs2uwAGEQUtvtC8+gEVXXyIyaSrpQ==
X-Received: by 2002:ac8:59c5:0:b0:51a:8c9b:649f with SMTP id d75a77b69052e-5213d0c7347mr123946891cf.67.1784539546657;
        Mon, 20 Jul 2026 02:25:46 -0700 (PDT)
X-Received: by 2002:ac8:59c5:0:b0:51a:8c9b:649f with SMTP id d75a77b69052e-5213d0c7347mr123946431cf.67.1784539546190;
        Mon, 20 Jul 2026 02:25:46 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:65fa:60cb:c205:d511])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955de88951sm62228205e9.3.2026.07.20.02.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:25:45 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:24:53 +0200
Subject: [PATCH 6/8] mfd: tps6586: use platform_device_set_fwnode()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-pdev-set-fwnode-instead-of-of-node-v1-6-2dee93f42c54@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=907;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=A6rTQywiVuri+akWPu8ZuzmrgFMwkmEBL5RABzyTsAA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqXel+JVh2LLebfg0Z60TjK/ZqooFO/E063bUsn
 DcFFoaXAHyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCal3pfgAKCRAFnS7L/zaE
 w2/uD/0aPKY8tpTuQyVi4bVwQxAwSe5GwjC2DtgnMo6nh/diKnBHmP8CrS17h3oxzaLBbpoQsyv
 Sz7j//KhI2uvM/6lsN12ObBAmWBE1OIY2cI2EITf9uARRqijYfV+vh3K099Z2WSPyIztcA7JV1a
 LXzZb7ugoqz2dMzT1dYxuTYTKlupbAIUqn3iCnldu412Ogk7U1TlAiPXUx8NUiwcSTgNJH6JtjG
 ybhBOe1z5foPXCLYPHg/mB/yn58+1Cndf7uN6COgbJKsYybBcSfm7GwhrfIR3kOESCkTPUQ/wKa
 CtSLDtJYyB3h0iOJVjA1wxmvViV3DncYABZdM9JhjlGr5xekEnOEIkt5J6dyoA6W3qAdQfM+wDe
 WHnnp/KwxzQBF0DZMHAzzpoGyj4CiF+A0L9ufwf2uDn/Gr6QSF3i1uh7g3B9Au9fYk4fZJVPzjL
 EreBD5gpBiQV4/muSmW+73v2B/YzUR/9/++LXGtpFgoyz9CAYZz8Hc2q0lwgczqGG/yerhUZ7Iw
 2svI6neY8mLXD64gJd+3QIabFLBehBoppvlO1WSrRtFtjFWC6wlYnhuX3lwh2ugV3XC2oWE+fzO
 N24Bq1v0R7mTGsTx4YHFYiArfM737K0E9k47o1YA1cm04PfUgXMiuD7g5S8kXEV39VNN8Mvf0py
 8hgioC0XlGh1TYg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX6rSxwBCEoVaH
 8XUZsCfOGt2qmkw7RoZKeBkVSfjjbfwPrDE+iUzTkAD34YPFVsSysJdEPh7XsdsExGN5cLycCEm
 BsHQ0BKcBGe/0ywIRyPVvF184Kl8U8Q=
X-Proofpoint-GUID: dQ3-VIAZ7Yhbd7DfrN3bwYyBoAHAxjle
X-Proofpoint-ORIG-GUID: dQ3-VIAZ7Yhbd7DfrN3bwYyBoAHAxjle
X-Authority-Analysis: v=2.4 cv=c+6bhx9l c=1 sm=1 tr=0 ts=6a5de99b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=s4_jwgGKpBPlvUtSdncA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX8GZ/f16m8/07
 8W0DWHjul4dqK1cHGYol81McJ/6kj2MokVJARJ9ik4299wQMdi3PY/JZis/aR3IzsSVS2vtdgDD
 4vMt8EUH4MIClzEraS3okKlunFEbyKclt/8/vFS7XP/QYArK0poAPj8kFwgb+inebUZ76GbbZm1
 iYxdX4Nxoi6sYykwgjrfrfIvANv/5lB52Zis517X5i1VS3namPwEhh8Ko+OHGnYyS8DFYq3bVSf
 WBmL0VJ4P66AVpQyzW+U1JFEaGwCR1iYSQCWIDgPu2grJ654iLelBQX/HPHfp4mygYtekoJvsHZ
 GkAU0rgWKNH+7H01TTl19lRnGIZpNA9LEmvvHFxQVr+yt9oERvMRzvrCJQby+haUe/088sRSDDb
 DfHiUOvzb3mQTrNZ5UbSK7z0mkwBoUKNi2/MaCF1RQg8e2yim61FRZ6C5xyaCf1zgIqrt9BzUCt
 oHM3a0vbL6ARTRlCsWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200104

Prefer the higher-level platform_device_set_fwnode() over the
OF-specific platform_device_set_of_node() for dynamically allocated
platform devices.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/mfd/tps6586x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 3cfd2f02b62f3cc370e0d970ec2643b638fd0fec..fc7c4b55c385416741925904abae4fd240f55b13 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -397,7 +397,7 @@ static int tps6586x_add_subdevs(struct tps6586x *tps6586x,
 
 		pdev->dev.parent = tps6586x->dev;
 		pdev->dev.platform_data = subdev->platform_data;
-		platform_device_set_of_node(pdev, subdev->of_node);
+		platform_device_set_fwnode(pdev, of_fwnode_handle(subdev->of_node));
 
 		ret = platform_device_add(pdev);
 		if (ret) {

-- 
2.47.3

