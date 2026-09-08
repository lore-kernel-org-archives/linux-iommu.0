Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5343976A4
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 23:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909400; cv=none; b=FpQ7uh+YtLi+npRUxjgARG8OC7b6YDyLzEaoZBwh/BMlMz2daP5+c1RWVoUIcYPbGa0h4PN9bGVshXdp8w0aqVrNEr5MAiKaI+j1vW60L71sEAsjI933op1rzN1+PpbFd58p3PPoEyaUWazZaqLhU8wL9ksJD+y3tWQUfK6PFck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909400; c=relaxed/simple;
	bh=7gH0DdCcJ8z5QZeIJ8H1KTKklRXXtiA1S6fS/5PxSBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfG0X46ek8RK724yYO19rJqte5exjIg+E6fKv1hiwgVbpD77QQSxK+H0TY0XQ0OMU0sPXcy4jn61AFqnr54qW0DpUQeaGpsKbH1Mit6ixaPuAKJI8nYO54TtE5kZhaBFaVflYhBmyYNAMbgiqbJ5XHnHj2NTgPmG/ft9NytacCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QnRZI6nv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eOL+KHEU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QnRZI6nv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eOL+KHEU"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688Mg5AB1274428
	for <iommu@lists.linux.dev>; Tue, 8 Sep 2026 23:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5OpX0FvQVUkIQJtPqzVnZ/Nb
	Tsx2FqQIdJRRkVKt+og=; b=QnRZI6nvjSo5DsAESsy6xbYDktBxBT2IRdqnBI7X
	FCnj5oDNDyM/LJZns946y4evuRXzVWe+iXP+dgtfASwlaoTnsB7Uo4HOfjB4ja0M
	E2dSXKXzXj9whr/narRp2sCBn1GB++SBVDyRZ9kqlI2caj2uPtBUF+QNlTn3yxpU
	Mf/C/q0alRXIhMWsvH61poIu8Nq49W3EL0SQJbgdcZO/x8K57LklWwR5luwaSAw8
	KFdAFI78cw8Wws1d0Bk0EDNWh1lh7fwRxzXV0U8TFhyB8/2UMHXnh52+53/+EU0r
	muLhvJwdgjvL4solreMgpjZiq6ZleDqwQKJkeW6ExeorDw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqdw18f1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 23:16:37 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-73883529f72so4181477137.3
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 16:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788909396; x=1789514196; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5OpX0FvQVUkIQJtPqzVnZ/NbTsx2FqQIdJRRkVKt+og=;
        b=eOL+KHEUNIF+UJI4JmN+op+YJ1rUzpMzUNX3OJek/NjfYhH2x1atWv/jQwhnyWKFt5
         nsFTMWzavWbf4jU1giVbo2EbbxjLv5vbz/YAtxo7wzIbZpIcFoK0mZfrnmoO2VGyDg3N
         naXqdV5j5rL4F8GIkbsSMQ1PhO3p8n3FV3OBsxlqoTNgKJ5De1csT3O7+NyaWapguGq8
         vKX30mRH/EGCFFA5LcRByoQmsrfYEZY20YpGf4k1eFClZ1XGJgIIF4iT0fq3Alvv7AA0
         rpwtp8kz4uJoWwmeQTe+j4J1RQdFt01dKfv1LkMkSMZXmlWo7KrwBeVs9ESgprbbEbn8
         OgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788909396; x=1789514196;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OpX0FvQVUkIQJtPqzVnZ/NbTsx2FqQIdJRRkVKt+og=;
        b=JDEtEBVZr9ZjR5wnzM6Cw73+1tjmB+VU9vIsHFYDyt6dot7xRKlSGhwb/EDo6vQTdK
         sk8chc8YtiXNJAWt+wZqf1Y9FT69zS/OMVGggO2UuIGVFx3EC98nyNoai2CasHein4Hy
         6plTpC/XiuiC0bWANkfWJgrwucLZpn5nFMIRIXUNdtxsVR0jsQLjQeVY7Y16zh1/Ex1w
         x7V9DsXhAPl8/PxaDZxyoRNAM2Mn3JVBiNqgxeHB5qd/378o5AppYmsn+5Q9mtMUkOu+
         cFDAxsBwBdDz04dkxKjPcvv/GbJG/hofynOVgJd7bjzEefBWtOi9x9py2qhllVZAIl/I
         HmWQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHl0ucwSxJjxzb031x+zetS6ODns8jern/qqzfynQwGwhuOQLxng0G8ECylMrKbKFT4/uyJA==@lists.linux.dev
X-Gm-Message-State: AFuF++mtFA1/NxRTPCjZ4Kbnm/VCBrvEOrpUIFJwLQk7+ZoOQQ9yfy4p
	+JF48rrg7gq4QI6/v6BciYFST0t8tGZ5/6iQK2+f/ZWX7fkyg+117gTUYSm+MhPa1pCXBrKGTTa
	qfKSHGlqPm3TCpu2dYF+QxMgm4cd1EnrxXlZwLEIh6lvr6rVk6FuoDl6s+A==
X-Gm-Gg: AYBFou2s4NQ3Z6w9Ar76GAzV4VUixkNoiMwr1IzKtMxcvl7D5Uuv244w9a9IsmVCwkX
	nRTiKPgeK6hEszmuCVuuIBXMp/62Ztc/OUHFgfQSIWrxvUM9v9aXQFxBt9wtf4BeIkkS9r2tDvr
	lR14cj4ekXOQtxgZYoGEM8O+99HcSDQ9jGx2kNZTyUvEBQV51vaoI41e7A6as8ynr/5LypWDg8u
	X8eGkgFe+Vjh0DYk3HUsrEzrmgTpqQr/rVVNLO/4pa/XbCdPpG2H1nlcq323iM3fEgIYB1Iz9M6
	s87L/xsXjnhd3fO3G4NIZA9Lb7hibaBwhZ9OxbJtw1wlk09h48T4FUw3AbZ1EdMdjsraHRJruac
	YyJX2Ns48SoxYOkqEQ/YrchflxZNoj+aW0ruC0N5zpd+yY+jdVI1RcgZ/3CobZMAlsy9X04IIU1
	4sOIS6ug7V7zuK
X-Received: by 2002:a05:6102:5126:b0:785:5a17:739b with SMTP id ada2fe7eead31-78a4a4944femr15114660137.0.1788909391528;
        Tue, 08 Sep 2026 16:16:31 -0700 (PDT)
X-Received: by 2002:a05:6102:5126:b0:785:5a17:739b with SMTP id ada2fe7eead31-78a4a4944femr15114434137.0.1788909386306;
        Tue, 08 Sep 2026 16:16:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a3705ed75dsm39469231fa.40.2026.09.08.16.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 16:16:25 -0700 (PDT)
Date: Wed, 9 Sep 2026 02:16:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 12/15] accel/qda: Add FastRPC invocation support
Message-ID: <ja2usiwasnu2x7lgx2xjsk57mew2nj7szn6ruqo6v7d2cpjcqe@xjpmxfkhxqkn>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-12-69a02e9090d4@oss.qualcomm.com>
 <hbrtbfpmcodd3nkaytihzki56232bws7ubbcth7ewwckwi5y6t@ft4ej4fr7duz>
 <3f644c83-ffd6-452d-aa81-1c13aaa397ac@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f644c83-ffd6-452d-aa81-1c13aaa397ac@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 8aNONkFrD1x9i_AEuHBkv5I1wzO9iAKH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDI1NSBTYWx0ZWRfX1oDIndBnq0Uc
 ceJOdGBTC5g8exkb2U+OQths7aX62egHfwR2rFiLlcM0J9msJ3CAvSTf5eyWkM+oOTX9q3FVBTJ
 AImYXHF1BLahl5AQhzDlUPXqefqhGgM=
X-Proofpoint-GUID: 8aNONkFrD1x9i_AEuHBkv5I1wzO9iAKH
X-Authority-Analysis: v=2.4 cv=Bo2tB4X5 c=1 sm=1 tr=0 ts=6aa09755 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=NJr1yQlnZ1qXxQj-jTwA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDI1NSBTYWx0ZWRfX1EQOX9wsTXb5
 c5PTfbFw3JwTGYBD4sO3cEenbbP+CflQ0GQy3jyT9Qe84Qix9bDD6VgvVdO4aVw2IXDBdOa4jkt
 /t7mUynSrOpoeTKkycAEfZYmhN05plgkTrrVC4iZds0CVV3eD5q9xRiEmV/vJ9WQ6FeCoJzRGL9
 cT30ZwfpPWDFZM35P4IfbyrBgFV7ZfEQOje70jxCuim/65mwRzk6zzxNRIzYmdWcShYKOWDSPR0
 eBfWO/UsFjYK4hEBY7mUtY9S4L8m2Ghfl5hsNZHkUcxgy7XIZqNTq3ck3YWzy5xGHJ1PcXHxC1H
 +ezM9QqqUTl2GmvQlj/2yeqqousy+hRQx2/8CFhi9OwOgb8SqJiI5b7IASPVPUiB4FeQXOICU0J
 3+jHW8QAHJxVwppVyUSX3lEMNBP7H9mYBi0SJtCGWegcpMVqUGNXrGrCiqcmogKKyKi8oSh3/NU
 U+xcLHda7AsebjUwzqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080255

On Thu, Aug 20, 2026 at 02:05:01PM +0530, Ekansh Gupta wrote:
> On 18-08-2026 09:49, Dmitry Baryshkov wrote:
> > On Mon, Aug 17, 2026 at 10:17:47AM +0530, Ekansh Gupta wrote:
> >> Implement the FastRPC remote procedure call path, allowing user-space to
> >> invoke methods on the DSP via DRM_IOCTL_QDA_REMOTE_INVOKE.
> >>
> >> qda_fastrpc.c / qda_fastrpc.h
> >>   Implements the FastRPC protocol layer: argument marshalling
> >>   (qda_fastrpc_invoke_pack), response unmarshalling
> >>   (qda_fastrpc_invoke_unpack), and invocation context lifecycle
> >>   management. Each invocation allocates a qda_fastrpc_invoke_ctx which
> >>   tracks buffer descriptors, GEM objects, and the completion used to
> >>   synchronise with the DSP response.
> >>
> >>   Buffer arguments are identified by GEM handles. Userspace imports any
> >>   DMA-BUF fd to a GEM handle with DRM_IOCTL_PRIME_FD_TO_HANDLE before
> >>   invoking; the driver never accepts DMA-BUF fds directly. Each argument
> >>   is described by its GEM handle, the user virtual address of the data
> >>   and its length, from which the driver derives the offset within the
> >>   buffer and the page-aligned range to describe to the DSP. Packing
> >>   several arguments into one buffer, and any overlap handling, is left
> >>   to user space.
> >>
> >> qda_rpmsg.c
> >>   Implements qda_rpmsg_send_msg() which sends the wire-format
> >>   fastrpc_msg (embedded as the first member of qda_msg) directly via
> >>   rpmsg_send(), and qda_rpmsg_wait_for_rsp() which blocks on the context
> >>   completion. The RPMsg callback dispatches responses to waiting
> >>   contexts via the ctx_xa XArray.
> >>
> >> qda_ioctl.c
> >>   qda_ioctl_invoke() drives the full invocation lifecycle: it builds the
> >>   invocation context from the user-supplied arguments, packs the
> >>   arguments into the message buffer, sends the message to the DSP, waits
> >>   for the response, unpacks the output arguments back to user space and
> >>   releases the context.
> >>
> >> include/uapi/drm/qda_accel.h
> >>   Adds DRM_IOCTL_QDA_REMOTE_INVOKE with struct drm_qda_invoke_args and
> >>   the per-argument descriptor struct drm_qda_fastrpc_invoke_args.
> >>
> >> Assisted-by: Claude:claude-sonnet-5
> >> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >> ---
> >> Changes in v2:
> >> - Drop the DMA-BUF fd argument path. Buffer arguments are now identified
> >>   by GEM handles only; user space is responsible for importing fds to
> >>   GEM handles before invoking (Dmitry Baryshkov)
> >> - Leave argument packing and overlap handling to user space rather than
> >>   supporting several buffer-passing formats in the driver
> >>   (Dmitry Baryshkov)
> >> ---
> >>  drivers/accel/qda/Makefile      |   1 +
> >>  drivers/accel/qda/qda_drv.c     |   8 +
> >>  drivers/accel/qda/qda_drv.h     |   8 +
> >>  drivers/accel/qda/qda_fastrpc.c | 434 ++++++++++++++++++++++++++++++++++++++++
> >>  drivers/accel/qda/qda_fastrpc.h | 242 ++++++++++++++++++++++
> >>  drivers/accel/qda/qda_ioctl.c   |  83 ++++++++
> >>  drivers/accel/qda/qda_ioctl.h   |   1 +
> >>  drivers/accel/qda/qda_rpmsg.c   |  91 ++++++++-
> >>  drivers/accel/qda/qda_rpmsg.h   |  26 +++
> >>  include/uapi/drm/qda_accel.h    |  42 ++++
> >>  10 files changed, 934 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
> >> index fb092e56d7f3..2d10420cd1ec 100644
> >> --- a/drivers/accel/qda/Makefile
> >> +++ b/drivers/accel/qda/Makefile
> >> @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
> >>  qda-y := \
> >>  	qda_cb.o \
> >>  	qda_drv.o \
> >> +	qda_fastrpc.o \
> >>  	qda_gem.o \
> >>  	qda_ioctl.o \
> >>  	qda_memory_dma.o \
> >> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> >> index a68a07d0ae56..f925bbcfa6e9 100644
> >> --- a/drivers/accel/qda/qda_drv.c
> >> +++ b/drivers/accel/qda/qda_drv.c
> >> @@ -25,6 +25,8 @@ static int qda_open(struct drm_device *dev, struct drm_file *file)
> >>  
> >>  	qda_file_priv->pid = current->pid;
> >>  	qda_file_priv->qda_dev = qda_dev_from_drm(dev);
> >> +	qda_file_priv->remote_session_id =
> >> +		atomic_inc_return(&qda_file_priv->qda_dev->remote_session_id_counter);
> > 
> > What happens on the wraparound? What if some of those sessions are still
> > alive?
> collision would require 2^31 opens without close, is this reachable?
> Should I add a comment here? Or some how address this?>

Just address it in the driver, disallowing such collisions. If there is
a way for the counter to wrap, it will wrap once.

> >>  	file->driver_priv = qda_file_priv;
> >>  
> >>  	return 0;
> > 
> > [...]

> >> +
> >> +/**
> >> + * struct fastrpc_remote_buf - Remote buffer descriptor
> >> + */
> >> +struct fastrpc_remote_buf {
> >> +	/** @pv: Buffer pointer (user virtual address) */
> >> +	u64 pv;
> > 
> > pv would mean physical something. Also, where do you validate the user's
> > address? Where do we check that it's ok to access the buffer, that it's
> > not a garbage?
> this is inherited from fastrpc(same is also used on DSP firmware) but I
> can rename it to something more meaningful like addr/va. This `pv` is
> used for offset calculation which eventually gives address of the page
> carrying the buffer. I can add checks when this calculation is done to
> ensure the pv is in proper range of the buffer passed by user.>

Don't inherit bad names. Don't use 'user virtual address' unless you
really mean __user. In the latter case the address must go through
access_ok() checks.

> >> +	/** @len: Length of the buffer in bytes */
> >> +	u64 len;
> >> +};
> >> +
> >> +/**
> >> + * union fastrpc_remote_arg - Remote argument (buffer or DMA handle)
> >> + */
> >> +union fastrpc_remote_arg {
> >> +	/** @buf: Inline buffer descriptor */
> >> +	struct fastrpc_remote_buf buf;
> >> +	/** @dma: DMA-BUF handle descriptor */
> >> +	struct fastrpc_remote_dmahandle dma;
> >> +};
> >> +
> >> +/**
> >> + * struct fastrpc_phy_page - Physical page descriptor
> >> + */
> >> +struct fastrpc_phy_page {
> >> +	/** @addr: Physical (IOMMU) address of the page */
> >> +	u64 addr;
> >> +	/** @size: Size of the contiguous region in bytes */
> >> +	u64 size;
> >> +};
> >> +
> >> +/**
> >> + * struct fastrpc_invoke_buf - Invoke buffer descriptor
> >> + */
> >> +struct fastrpc_invoke_buf {
> >> +	/** @num: Number of contiguous physical regions */
> >> +	u32 num;
> >> +	/** @pgidx: Index into the physical page array */
> >> +	u32 pgidx;
> >> +};
> >> +
> >> +/**
> >> + * struct fastrpc_msg - FastRPC wire message for remote invocations
> >> + *
> >> + * Sent to the remote processor via RPMsg. This is the exact layout
> >> + * the DSP expects; do not reorder or add fields without DSP firmware
> >> + * coordination.
> > 
> > __packed?
> I'll check more on this.>
> >> + */
> >> +struct fastrpc_msg {
> >> +	/** @remote_session_id: Session identifier on the remote processor */
> >> +	int remote_session_id;
> > 
> > Is it int or u32?
> This is again from fastrpc where it's a mix of int and s32. I'll keep it
> the to actual s32 here in QDA.>

Thanks. Also please stop using fastrpc_ prefix in the QDA driver.

> >> +	/** @tid: Thread ID of the invoking thread */
> >> +	int tid;
> >> +	/** @ctx: Context identifier for matching request/response */
> >> +	u64 ctx;
> >> +	/** @handle: Handle of the remote method to invoke */
> >> +	u32 handle;
> >> +	/** @sc: Scalars value encoding in/out buffer counts */
> >> +	u32 sc;
> >> +	/** @addr: Physical address of the message payload buffer */
> >> +	u64 addr;
> >> +	/** @size: Size of the message payload in bytes */
> >> +	u64 size;
> >> +};
> >> +
> >> +/**
> >> + * struct qda_fastrpc_invoke_ctx - Remote procedure call invocation context
> >> + *
> >> + * Maintains all state for a single remote procedure call, including buffer
> >> + * management, synchronisation, and result handling.
> >> + */
> >> +struct qda_fastrpc_invoke_ctx {
> >> +	/** @node: List node for linking contexts in a queue */
> >> +	struct list_head node;
> >> +	/** @qdev: Device owning the XArray this context is registered in */
> >> +	struct qda_dev *qdev;
> >> +	/** @ctxid: Unique context identifier (XArray key shifted left by 4) */
> > 
> > Why is it shifted by 4? Why not by 3?
> I'll add the PD encoding comment here.>

So, why?

> >> +	u64 ctxid;
> >> +	/** @inbufs: Number of input buffers */
> >> +	int inbufs;
> >> +	/** @nscalars: Total number of scalar arguments */
> >> +	int nscalars;
> >> +	/** @nbufs: Total number of buffer arguments (inbufs + outbufs) */
> >> +	int nbufs;
> >> +	/** @pid: Process ID of the calling process */
> >> +	int pid;
> >> +	/** @retval: Status code reported by the DSP for this invocation */
> >> +	int retval;
> >> +	/** @remote_session_id: Session identifier on the remote processor */
> >> +	int remote_session_id;
> > 
> > is pid linked to remote_session_id?
> not really, remote_session_id is more of session specific, so in case of
> multi-session(same PID having multiple sessions) should have different
> remote_session_id.>

Then drop the pid, please. You already have a session here.

> >> +	/** @pd: Protection domain identifier encoded into the context ID */
> > 
> > If it's already encoded, why do you need it here?c
> it's stores so the packing step can use it, I'll document more on this.
> Or if I can have both msg->fastrpc.ctx and ctxid same, I'll check that
> also>
> >> +	int pd;
> >> +	/** @type: Invocation type (e.g. FASTRPC_RMID_INVOKE_DYNAMIC) */
> >> +	u32 type;
> > 
> > What other types can exist?
> I'll add all the types in document or just add FASTRPC_RMID_* and point
> to qda_fastrpc.h for more details.>

Do we really need to support those in the first iteration? I think you
should have heart it several times: get the minimal sensible driver in.
You can add all the features afterwards.

> >> +	/** @sc: Scalars value encoding in/out buffer counts */
> >> +	u32 sc;
> > 
> > Remove it and calculate from in/outbufs above?
> The source of sc is the auto-generated stub file which passes this to
> remote_handle_invoke() based on the method requested by the user. This
> as is as it is passed to DSP where this is used in auto-generated skel.
> 
> I think the other way around(in/outbufs from sc) would make more sense.>

ok

> >> +	/** @handle: Handle of the remote method being invoked */
> >> +	u32 handle;
> >> +	/** @metalen: Length of the FastRPC metadata header in bytes */
> >> +	size_t metalen;
> >> +	/** @pkt_size: Total payload size in bytes */
> >> +	u64 pkt_size;
> >> +	/** @aligned_pkt_size: Page-aligned payload size for GEM allocation */
> > 
> > ???
> I'll check and remove this.>
> >> +	u64 aligned_pkt_size;
> >> +	/** @list: Array of invoke buffer descriptors */
> >> +	struct fastrpc_invoke_buf *list;
> >> +	/** @pages: Array of physical page descriptors for all arguments */
> >> +	struct fastrpc_phy_page *pages;
> >> +	/** @input_pages: Array of physical page descriptors for input buffers */
> >> +	struct fastrpc_phy_page *input_pages;
> >> +	/** @work: Completion used to synchronise with the DSP response */
> >> +	struct completion work;
> >> +	/** @msg: Pointer to the QDA message structure for this invocation */
> >> +	struct qda_msg *msg;
> >> +	/** @rpra: Array of remote procedure arguments */
> >> +	union fastrpc_remote_arg *rpra;
> >> +	/** @gem_objs: Array of GEM objects imported for argument buffers */
> >> +	struct drm_gem_object **gem_objs;
> >> +	/** @args: Invoke argument descriptors */
> >> +	struct drm_qda_fastrpc_invoke_args *args;
> >> +	/** @refcount: Reference counter for context lifetime management */
> > 
> > What for?
> just to ensure that the context is not freed in case the
> wait_for_completion() is interrupted.>

If it's not _interruptible, it can't be interrupted. Or there should be
a better description of the reasons.

> >> +	struct kref refcount;
> >> +	/** @msg_gem_obj: GEM object backing the message payload buffer */
> >> +	struct qda_gem_obj *msg_gem_obj;
> >> +	/** @file_priv: DRM file private data */
> >> +	struct drm_file *file_priv;
> >> +	/**
> >> +	 * @req: Request buffer for the internal init/map/unmap calls.  Points
> >> +	 * into a kernel-owned GEM mapping tracked by @gem_objs, so it must
> >> +	 * never be freed directly.
> >> +	 */
> >> +	void *req;
> > 
> > Why do you need separate pointers here? Can't you be getting them from
> > msm_gem_obj?
> These are typed pointers into different offsets of the kernel GEM
> mapping. I could compute them each time from `msg_gem_obj->virt +
> offset`, but caching them avoids repetitive casting. Let me see if
> removing this looks cleaner.>

Calculate them when necessary. If you use them in a few places, they
don't need to be cached.

> >> +	/** @rsp: Response buffer, same lifetime rules as @req */
> >> +	void *rsp;
> >> +	/** @inbuf: Process-create input buffer, same lifetime rules as @req */
> >> +	void *inbuf;
> >> +};
> >> +
> >> @@ -84,6 +88,44 @@ struct drm_qda_gem_mmap_offset {
> >>  	__u32 pad;
> >>  };
> >>  
> >> +/**
> >> + * struct drm_qda_fastrpc_invoke_args - FastRPC invocation argument descriptor
> >> + * @ptr: Pointer to argument data (user virtual address)
> > 
> > Why do you need it? Is handle + length not enough? If you want, specify
> > offset inside the GEM BO.
> The user VA (`ptr`) is needed because userspace mmaps the GEM BO and
> then passes pointers into it to the DSP. The kernel derives the offset
> within the BO from the VMA (via `calculate_vma_offset()`).
> 
> I can check if just passing handle + offset + length works here but that
> might require some userspace change.

You are going to have a different userspace. It must pass only
handle+offset+length triplets. All the rest must go to the compatibility
layers.


-- 
With best wishes
Dmitry
