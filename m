Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D023E9C3D
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287035; cv=none; b=t6L26ze4WZpn0g69M/cVH6i46HI3vNerWRjHYyiWGTY9pL0i7MeUrX3aCgQfs2aE2BIsJmOfcKQAjFDkZkGJTNWmgNVuAtPKPh0OU6G/aFxBiQMpcQfTK5Uf2Hnb7eYIZhIASrNOASMew8+x01Y/qlBOt93hdXz9evl4/gDDN9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287035; c=relaxed/simple;
	bh=qmCaiUhsXRp1nBJFDpnj4/1kbPlAml3acNXDkbqeY8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jU4yXw4AQQvgkl+AJ8tXJai86Ey+UwVsBdFWIu2cXgcF8eS+LuuQLRVjPTamGyQzXVLk3K4NJWSSJB71S9H7AgMPn/HiHpFodVecNv0LvXkKwj1V/9UFasGvsN/tFNU4UmkI5lG9NB7IK1RFnWM1JQ8wKYSrsEHqFIeQGyRvrTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LgmR/z7d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SeX7EN4v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LgmR/z7d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SeX7EN4v"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K9ocvH1178288
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zZgC57Ii0BTYgfnbECyQYyWw
	TDZMq6Ouh/2/CXADmS0=; b=LgmR/z7dVuueTtWW/lppz/vir7A6gg1VwtnB751Y
	GfD0zhBwFbr1SUGpI/3RkOoQSNDjKHEQ3pfs9fLv9hJ9+iFv8/PQCxgjXhLDa7ow
	lnc/RkTazKRZcdyuyeb/WWhP3u/jY2H9j7snh6dhPT12XVJ4Rn5pMeTC7L/AjFd3
	lsj/FDUtPQtcDSqq0koLghczP3GbuwktTDPdgs0plONjD7a63QMxif7NKXB3KOKr
	eQw2ZRnKjJg0Co03zsPrJr9ol+oz+fRHK+OWA45z7y6t5Wpqog8+hqyjzZm3VeLX
	rgQpG76x9VGlTJgnpqpypUmdajaL0w4aNCEXQRmdFdOmNA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ap6rygn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:23:48 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-575456ad2b2so3793230e0c.0
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 07:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779287027; x=1779891827; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zZgC57Ii0BTYgfnbECyQYyWwTDZMq6Ouh/2/CXADmS0=;
        b=SeX7EN4viTqMnKMBScZZJwvmlPToroRvOFV/mwSP70QiU9/v/iAt0YfRolprxlU/Zq
         PlUyvOBDk2TrP+VqE+4C9ljxzSXFyl/GKhhUl+eXBoGT9xlWsDVfi8+17p+ueY1egNuu
         z+gyvw79cGjbbqYY7q985U96qtxru55EK41uAiSQT8IuWlUdraSbYI3Fif92uxZnl9Xf
         ZI1kRbfm85VhuLl+aMGckrV3QoLdJJbf+2XISfQXxrXlqRuvANouB9wXI9R0ktwXuZkP
         AEqJRwlqiLIsbhT/OnYf7Lfxg6CCUxIcLNMpCXqKxokFfdfZJE7pPuZ2jDs6dPgdPKX7
         aJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779287027; x=1779891827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZgC57Ii0BTYgfnbECyQYyWwTDZMq6Ouh/2/CXADmS0=;
        b=J9cyOgmYxl6GoXkqdr1Xb/2YTUGQrTGVOj00WWEfddZ9dY2I6WiA5hnOLGo4d5E6VH
         hB3mmNXFN2LgH/MSyRsTM4xVRBsjgA/8945pTPUbvvlSKPd3tl1xCiDZcH/ETKnq5SQM
         ivWZ+9q9aMtYyaOjT2c1++bAYu9LHmHKF0rirRhhrAPaotSPShGiWMentQyKZmgZnrWL
         5K3oTDD1s3QAA/8gGcNwMt9VVOZtL/WdB1cVZA3yLxgzHgZ0co7uLQul0dUTRY8x2fph
         ZekZDe1Yac9qmj8pVSS8jrtW0CsymYoSXXNXMFK5IPx0QTsifHd9CXCRu3NOEP+yFMNU
         /AkA==
X-Forwarded-Encrypted: i=1; AFNElJ9MOtDI7B9lkhdr+ETwGnutBhYpLtP1MVRaEPkYFwBzbejmmoVf/viJs3Ot9f0razGzahQ58g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAoR6lSzWZgxgwhRuSEGZJAiYwG4ZkpUPjWOySC4/H6OLP+55W
	fx4YXejYyJhBftDmv5/7ASN60MTuHTE1K4inlgt/dxDLprpzfPvkqi1A6p6VfLLy2PviZDLz33X
	fzJKcInfKFyj6j1iAIPIyfwFVo02l1E/V+U8370fIZT2xaIkYnjG9KATslA==
X-Gm-Gg: Acq92OFVRRqZclMBNibLfCh1BZEo6YUBByf9cmx+W3qNSTDn86BhDnwL+8AUe91L1N1
	zsyNhxXTUJo8tjjAIjFeio06pVnUqKj9E53oF2vAW+Tf5D4ooOUzYo+LfTReH8kR0x2lGn9ejE/
	0XXGJv4J/tDNL8nRw6JPv8EmAtZNjBY9zsqqrIRny8Y9k+ouJHMwRZGipUebJmTa2InjdNXoDtA
	EVV5FWZOLQKiC7x/hrckC9eBWPOir43zR8yWpW1Ob3UmcuEIFguxBngcpr58Yvi4C8y9ui7EA3L
	6FHrJawymfwbqY5b8DCAohM0nH9tFcwdzubF3S/MkHkBFm25RXBvCK8CO6HcESmMR1+N1pZKY1F
	w6c037q2Mdx+rwtegM5riLCIkjqGxC3GOiUUYdglN8i3a+bkfdpNIEHG4TzvKHPhKAsVmGvUfvr
	wc+dtwCuCWF55NlK9k90yDLpIvUuC4TZZghZKMRBjuKMTvAQ==
X-Received: by 2002:a05:6122:920:b0:56e:f071:d4ef with SMTP id 71dfb90a1353d-5760c0347e0mr11445817e0c.8.1779287026873;
        Wed, 20 May 2026 07:23:46 -0700 (PDT)
X-Received: by 2002:a05:6122:920:b0:56e:f071:d4ef with SMTP id 71dfb90a1353d-5760c0347e0mr11445742e0c.8.1779287026305;
        Wed, 20 May 2026 07:23:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164cf080sm4955924e87.74.2026.05.20.07.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:23:45 -0700 (PDT)
Date: Wed, 20 May 2026 17:23:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: ekansh.gupta@oss.qualcomm.com
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 06/15] accel/qda: Create compute context bank devices on
 QDA compute bus
Message-ID: <f527lflctqyqjrotd2qerlx4oikg6st6u2seqsjw6u5krkqrab@uhw33gnkp5c7>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-6-b2d984c297f8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-qda-series-v1-6-b2d984c297f8@oss.qualcomm.com>
X-Proofpoint-GUID: cilwhAcDfUotUlxbnyTrDDK6TrebwCxo
X-Proofpoint-ORIG-GUID: cilwhAcDfUotUlxbnyTrDDK6TrebwCxo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0MCBTYWx0ZWRfX5QoB0OmBSULN
 +qinM8P0MFbCnNeMAF5cfKRIYvAkq24lwmx3VqOJJ7Ee6COE3ilY7c2QL1cC37b+aDKbPYz3U3P
 NqpXi3s8TA8y7N1b7YzgEBvB2sJYcZ6zh2gDLoKFf0xEe35phi2DfYLxQH9wjN2eNxVsRZF5zMO
 L0EUGKATHAB7roP7Ds+nSfaf1c9PdZcWlGfW62FyZS9W0HYJESp0N0/JDRwrlHGlo78yl08askh
 ZcAqQr3oCvKRoMRosB6JE0UvPpcJ9gzVcBVnAbL1NgoC3uqh2+nPyubPvnpgBsbduGdXfPRnGTB
 BQ0vfDYPkCSzN/JJnYXsy+gXYuDfyKlgdj2MMddJgygPfzKhar9Vhbwnk7NbpBdeLcq6EsMPfEU
 8BczaNqHyOeWj2sq9wZhuldDHVBUO9ZBiSKos8DiJwXrR2h+3Hlmq0j4B2mFnL82XlGZKIxVGVk
 0iEyglY1CPIdw+JWy2Q==
X-Authority-Analysis: v=2.4 cv=FesHAp+6 c=1 sm=1 tr=0 ts=6a0dc3f4 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=R2qd4bXIq2Q-l4e3V4sA:9 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200140

On Tue, May 19, 2026 at 11:45:56AM +0530, Ekansh Gupta via B4 Relay wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> Introduce the CB (compute context bank) device management layer for the
> QDA driver. Each DSP domain node in the device tree may contain child
> nodes with compatible "qcom,fastrpc-compute-cb", each representing one
> IOMMU context bank. The driver enumerates those child nodes during
> RPMsg probe and creates a corresponding device on the qda-compute-cb
> bus for each one.
> 
> The CB devices are created via create_qda_cb_device(), which registers
> them on the qda-compute-cb bus so that the IOMMU subsystem assigns each
> device its own IOMMU domain, enabling per-session address space
> isolation for DSP buffer mapping.
> 
> The new qda_cb.c file provides two functions:
> 
>   qda_create_cb_device()
>     Reads the "reg" property from the DT child node to obtain the
>     stream ID, constructs a unique device name of the form
>     "qda-cb-<dsp>-<sid>", and registers the device on the compute bus.
>     A qda_cb_dev entry is allocated and appended to qdev->cb_devs so
>     that the list can be walked during teardown.
> 
>   qda_destroy_cb_device()
>     Removes the device from its IOMMU group before calling
>     device_unregister(), ensuring the IOMMU domain is released cleanly.
> 
> CB devices are populated before the DRM device is registered and
> destroyed before it is unplugged, so no DRM operation can race with
> CB teardown. On probe failure after population, qda_cb_unpopulate()
> is called to clean up any CBs that were successfully created before
> the error.
> 
> Assisted-by: Claude:claude-4-6-sonnet
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/accel/qda/Makefile    |  1 +
>  drivers/accel/qda/qda_cb.c    | 99 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/accel/qda/qda_cb.h    | 32 ++++++++++++++
>  drivers/accel/qda/qda_drv.c   |  1 +
>  drivers/accel/qda/qda_drv.h   |  3 ++
>  drivers/accel/qda/qda_rpmsg.c | 12 +++++-
>  6 files changed, 147 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
> index 424176f652a5..143c9e4e789e 100644
> --- a/drivers/accel/qda/Makefile
> +++ b/drivers/accel/qda/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
>  
>  qda-y := \
> +	qda_cb.o \
>  	qda_drv.o \
>  	qda_rpmsg.o
>  
> diff --git a/drivers/accel/qda/qda_cb.c b/drivers/accel/qda/qda_cb.c
> new file mode 100644
> index 000000000000..77caf8438c67
> --- /dev/null
> +++ b/drivers/accel/qda/qda_cb.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#include <linux/dma-mapping.h>
> +#include <linux/device.h>
> +#include <linux/of.h>
> +#include <linux/iommu.h>
> +#include <linux/qda_compute_bus.h>
> +#include <linux/slab.h>
> +#include <drm/drm_print.h>
> +#include "qda_drv.h"
> +#include "qda_cb.h"
> +
> +int qda_create_cb_device(struct qda_dev *qdev, struct device_node *cb_node)
> +{
> +	struct device *cb_dev;
> +	u32 sid = 0;
> +	char name[64];
> +	struct qda_cb_dev *entry;
> +
> +	drm_dbg_driver(&qdev->drm_dev, "Creating CB device for node: %s\n", cb_node->name);
> +
> +	of_property_read_u32(cb_node, "reg", &sid);
> +
> +	snprintf(name, sizeof(name), "qda-cb-%s-%u", qdev->dsp_name, sid);
> +
> +	cb_dev = create_qda_cb_device(qdev->dev, name, DMA_BIT_MASK(32), cb_node);

Wrong prefix. Pass the name format and the params to this function. Use
kasprintf in it.

> +	if (IS_ERR(cb_dev)) {
> +		drm_err(&qdev->drm_dev, "Failed to create CB device for SID %u: %ld\n",
> +			sid, PTR_ERR(cb_dev));
> +		return PTR_ERR(cb_dev);
> +	}
> +
> +	entry = kzalloc_obj(*entry);
> +	if (!entry) {
> +		device_unregister(cb_dev);
> +		return -ENOMEM;
> +	}
> +
> +	entry->dev = cb_dev;
> +	list_add_tail(&entry->node, &qdev->cb_devs);
> +
> +	drm_dbg_driver(&qdev->drm_dev, "Successfully created CB device for SID %u\n", sid);
> +	return 0;
> +}
> +
> +void qda_cb_unpopulate(struct qda_dev *qdev)
> +{
> +	struct qda_cb_dev *entry, *tmp;
> +
> +	list_for_each_entry_safe(entry, tmp, &qdev->cb_devs, node) {
> +		list_del(&entry->node);
> +		qda_destroy_cb_device(entry->dev);
> +		kfree(entry);
> +	}
> +}
> +
> +int qda_cb_populate(struct qda_dev *qdev, struct device_node *parent_node)
> +{
> +	struct device_node *child;
> +	int count = 0, success = 0;
> +
> +	for_each_child_of_node(parent_node, child) {
> +		if (of_device_is_compatible(child, "qcom,fastrpc-compute-cb")) {
> +			count++;
> +			if (qda_create_cb_device(qdev, child) == 0) {
> +				success++;
> +				dev_dbg(qdev->dev, "Created CB device for node: %s\n",
> +					child->name);

Stop counting successes.

> +			} else {
> +				dev_err(qdev->dev, "Failed to create CB device for: %s\n",
> +					child->name);

Unwind, return error.

> +			}
> +		}
> +	}
> +	if (count == 0)
> +		return 0;
> +	return success > 0 ? 0 : -ENODEV;
> +}
> +
> +void qda_destroy_cb_device(struct device *cb_dev)
> +{
> +	struct iommu_group *group;
> +
> +	if (!cb_dev) {

How can it be?

> +		pr_debug("qda: NULL CB device passed to destroy\n");
> +		return;
> +	}
> +
> +	dev_dbg(cb_dev, "Destroying CB device %s\n", dev_name(cb_dev));
> +
> +	group = iommu_group_get(cb_dev);
> +	if (group) {
> +		dev_dbg(cb_dev, "Removing %s from IOMMU group\n", dev_name(cb_dev));

Be uniform. It's either drm_dbg_foo() or dev_dbg() all over the place.
Don't mix them.

> +		iommu_group_remove_device(cb_dev);
> +		iommu_group_put(group);
> +	}
> +
> +	device_unregister(cb_dev);
> +}
> @@ -59,9 +61,17 @@ static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
>  	}
>  	qdev->dsp_name = label;
>  
> +	ret = qda_cb_populate(qdev, rpdev->dev.of_node);
> +	if (ret) {
> +		dev_err(qdev->dev, "Failed to populate child devices: %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret = qda_register_device(qdev);
> -	if (ret)
> +	if (ret) {
> +		qda_cb_unpopulate(qdev);
>  		return ret;

Unwinding registration?

> +	}
>  
>  	drm_info(&qdev->drm_dev, "QDA RPMsg probe complete for %s\n", qdev->dsp_name);
>  	return 0;
> 
> -- 
> 2.34.1
> 
> 

-- 
With best wishes
Dmitry
