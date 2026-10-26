Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995895;
	b=sAjQas+tKPWGVi+l0UshAR4vyYI9rGRaIGwk4K0Qy+5QOPlM9YAu9IX0NLCZJomTPpHa
	 CDLxylUJeoS2lO/fz63sncFge+ph2Jzs6qEaXJY5zK6VXP60N2/0FLWNnIYeCMJKp6DGf
	 cqhEM+CGbxwPW/3mDV6W7MT8erM2Q/MsWoXcABFK9nMR3LR001CWJinMyI+PhddbXpz55
	 CPAG72bVzR1DjNjz/J+bUk74k1xDbXPTIb6kTe7W0gMRhUkah/FC0mejF7a87rJTMHPrn
	 t4lzKlAUkVTxV1eSgRnqhjcFGy68VBtZwYlbnsyqrkl3UpTDFlCoddzH/HJFUEHAeYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995895;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Sy6FxDMRvFjw5nCdumQqAFyqQkzByWzKewADskjDzko=;
	b=47bH2JAIrIx0GGXP7fgFFHDAKQksnYlTClFNzJfQIcC6RxgR3farN3EIgkKMDzfZTlla
	 vKVNzrq/34OhlorPHTCb2dezH75KU4f/WvGxcK1oIpYrNKrM6WTuyCmYR89VnXTCdmXiV
	 EiUrAFAMbXsgX47eOmepE6Z9ldxS6P+YYhkBzbbEQKE+US1Tk8fg1y79S6c+8++uzbSBO
	 4Sfn//koM4Vgw1vP17ssYDbDeXzYENgrU6K+waFFqOfoWaUedzjKe5x8mrBLTMhfm6HFw
	 ZNigECmANiW06Qd18b31zCE3srhmOolQVsW6oE0/QsIm4wyQ+0rPH1SXT+KMld0OGxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RfO+XRp4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="bx/2p7h/";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50727606A321
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50727606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RfO+XRp4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bx/2p7h/
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4b17B2806328
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sy6FxDMRvFjw5nCdumQqAFyqQkzByWzKewADskjDzko=; b=RfO+XRp4pjYRM/xe
	mG9DK22XFlQQwhgLDBfJpX33NFBxj96FU7sl8qDGu+Plw5ex5UktXN2OLXZEcPB3
	lug8o00Xm0AzYhEad9Za2pih0Tbw5exLhKuoCnzPprxIuijvxz4zLfEKcFBfYNBD
	f5+Tb9YCPNgaxfkrq7X4qHuv8gdHeoQw+OyffCNvt95dE6s1lAH7r/ILD/USzVUm
	nwszRM9GZvSc0tqFQRJWBBDN6XG+UW+fGRSaExZ5Y1kMG3hd6Sy/gqDES2f0V+mA
	xysdEC50+zKS6USAkgaQint/7kg0MWwL/gfkLauR2rgrEFrK2k/1zcZdMguReItg
	yLnhew==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xn4fx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 06:24:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2eac6e96bd4so9601585ad.2
        for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 23:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995892; x=1793600692; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sy6FxDMRvFjw5nCdumQqAFyqQkzByWzKewADskjDzko=;
        b=bx/2p7h/tWtlIhAkJnV97eLFHy3lGyyQ8aI8175nIZO+tchSduKC1cy6nUU3bj61iz
         6q8G+1u842IY84wkYKDAvwSfzKHiEWPUwb53PyX2sm/rGqUgr/BsBsw3kNZ7vN8JFN+f
         WzI+pDIcOfRRFebq/S77Wq1laLcFr4koJbmB8lQBUzantyUZ3QoXshkP9BMYElkr8tHs
         Bi9HF6ItHJO6crtTF2wUlTiANH6mZuzW9KEh9kB8oRf6GBmUq0a7fO0tUmraLjcxXEYg
         qEhZG0cCOkbR9XXqQM8zzY2c1qb777cphJvKx6OGY1gnwtIDNmQz6kkBCas57mhRArop
         268Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995892; x=1793600692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sy6FxDMRvFjw5nCdumQqAFyqQkzByWzKewADskjDzko=;
        b=lQi7Y5tmaLqxQ07ExWRKTR/SDh+FaMotRt3oenFjURO7ssVrUJ/tV551yczhuq7AV9
         geHaQHQdCP7yTQvBuQpPaGOKUK0TVruWNAcOm7U4itlheDTQrxHjR5Yn1s0OaV1NhudH
         oeXzpOdFPXeW4LrgosC3Jrnni4rJEogl7BiSRZEUIDJvHXkCOEHS2V5e6A1nySIRMB7l
         GNbvvi9g4flAnxehSKCaU6Vg8PaQSKym33yy/4BOdLH2XxCUAVgOvGIWqgCqUuSx+nJB
         0onJODm8E4XEvNGAS7vOknyfI+eRzki9ruTtJP/RHKvCtpmp8Q0wp3htPPme8S96xL+7
         WF0Q==
X-Forwarded-Encrypted: i=1; AKwUvBw2Qck0DmcyLy3A1XFQNJVCMy3gRkc38mmbOEnFxZ6r0qSRiKPjVfpitjXQpGD8OqrA7QUmDQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKTmW/K3LIIHq8Qc/TiRByXpAwpzoUGRon5KndtwVt1xRfQWvpx
	47XToQ+TWj6jNxoGMluU/ea4mXqsWInVbBak+rPxuncM6HK42azrrZnCdpjvfxZwUB9snFrewGd
	SPYLwJub/w5bHY8Odo/GdNT4ImlUoeWbJVgdOugoa544Wlph1w0UWQ/my9w==
X-Gm-Gg: AYBFou2EY6Gv6gSsMJo2WuNMLxfKlFdPclLZ+Y3+MiMFTmgAMS6XvtkQHpDdQbvnPpk
	MvVWsA80ou1ZIsZebjjBrnY566Sqipt5MuJB8bbR6oTNXwndpezE/OznEmMyoV4hV5Hk4RBrJJA
	uXK/p4KszMxnEdNYh6wJokMwi+3zKkTJf7mTrQQBzS7Yd92ErMlRSFsObntN83cdHqfGK0k+P+Q
	ev4bBcwbNrRDuyqhnUxFwYAt4h0GyVqr4LgPwyWdKzQteP0CLmjUqxWIpMPokAPPW6cpfC6Omg2
	8+6fxg9RGMF/66MVIyyYdUUYOBGg9ykq7QoaHzZ3IwYTShRqYtjpPEWCwMtZh1pMtvgLFWA0XEP
	zGeBV7TOymgFb4D3rLwyG7Th08hlmpbaT2g==
X-Received: by 2002:a17:902:d4c9:b0:2e9:5b4e:b8a7 with SMTP id d9443c01a7336-2ea9c8ebd4cmr50093285ad.51.1792995892304;
        Sun, 25 Oct 2026 23:24:52 -0700 (PDT)
X-Received: by 2002:a17:902:d4c9:b0:2e9:5b4e:b8a7 with SMTP id d9443c01a7336-2ea9c8ebd4cmr50092955ad.51.1792995891873;
        Sun, 25 Oct 2026 23:24:51 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:24:51 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:28 +0530
Subject: [PATCH v2 18/23] virtio: Add Qualcomm Platform Services Firmware
 Interface ID
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
Message-Id: <20261026-jshekhar-dcp-hlos-v2-18-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>,
        Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
        virtualization@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        iommu@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=888;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=OlbpUMWfalcU4LvUc4XxjyJ0N4RsG6REGtg5lYpZB2g=;
 b=hqaldRzU9Cfrh8WAe0bLtlXt2+O+xAhC8XiFVF+11GcI+fP7EIgtkw/lV0bwk/zrXWsIWG3i6
 OCdlUUwhFkECpl0mDzYq/rh+5qzmVsGCw0XRLE0D382TWK/dkx/0epo
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-GUID: AAjjDiPdHvLDN9VFqKKJHe9fpsiv0mxd
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6adef235 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=WCyPByqoPTdveakBLZ4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX/S9iUeYh4qHb
 9q67VDH+4hLO19UVtUjVxzPAN0sCrp6HUfGNhKc0X7NNIvRWPJYi2E/yZYU4hUmE6Zp9AGGKduI
 1MkCK+u2Zw147FcviJMRIxdy21zzBSQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX80uDHj3H4C0x
 nJEGIGkn7p3zcpsmrHW3d9bvoFNrjbshjZ1+J827nVIqJ2qJQrWgE/jlAXacm6yFT0TrngwjGnO
 rkTcANjdrfbMhXGViD/PplsaGbmGu1s2as/wmS/qorI/pHK3Lt3BkhUSApB1nQ4XThqnAzYuN6I
 yNcElVW4FrLkMjygoGk1bf7Zj+GKFggKeH/pzfC0Ab93xgWpl1IoX8jzA0JB6AS0KGbwR1R/HhU
 M2+O0oo5ycQMBpoRoymftO+NqjALI37MycRZuY68xF0QWhS5DVh/YsS4D+Vm5vkjp6qV5gT3+7b
 rR2ayDsnyt2r7hbF9TwYBrl3bd6Ru93tnV9qzgAPpdSLhw5YCyR73HQ0/9Jq+b4vX6C+LLy4lec
 FARTulq7IqOFpRiPhV33A8M0Fprcd++dUl2iwM1mfyABTmmhDbIUvP+MsOPIyN85U+Ak+7mOjRi
 2HZZ2iQdiQ6NoLASk/g==
X-Proofpoint-ORIG-GUID: AAjjDiPdHvLDN9VFqKKJHe9fpsiv0mxd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025

The Qualcomm Platform Services Firmware Interface (QPSFI) is exposed
as a VirtIO device with device ID 52. Define VIRTIO_ID_QPSFI in the
common VirtIO ID header so transport and function drivers use the
shared identifier.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 include/uapi/linux/virtio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index f9056af0c622..6c6f283733b1 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -70,6 +70,7 @@
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
 #define VIRTIO_ID_SPI			45 /* virtio spi */
 #define VIRTIO_ID_MEDIA			48 /* virtio media */
+#define VIRTIO_ID_QPSFI			52 /* Qualcomm Platform Services Firmware Interface */
 
 /*
  * Virtio Transitional IDs

-- 
2.43.0

