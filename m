Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FFE395276
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786945489; cv=none; b=lkPg92YJduA4hKdinQDciyOVrTfzfxj0626Q3kSccaj38XLok/sQ6oouGyf+HU7KjfVDTH6CKN3rL9VSTznxqTcCyyhBG5l5y1V09bR+bup5duAYqKtBp1zb5LhjeeiIRR5HGeDhJZDHC4CmC8hSKUhpZjgGIFSxHzYGdWQ3HAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786945489; c=relaxed/simple;
	bh=BOsWlzsNjRjW+LGvfzEBsGi7iZHKZ6oJ+OnpFU+/UbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4sQYLLpoMe//W04x7IeyTNE8GlusASPqDf2Jc7WzbXrQNmVUEHW6QNAr8dQburnRp1y6Ux23GW1U3IQO/TkMI1wX+gQDQac6dMojRJVQTHbznMC2ivMtoXlkru1LcM+Rj4w2gZ3l64pdW9iJdeJQPmTDMXfW1PPKhynUhK4X+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZB+O1Wf5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NIJsPLV1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZB+O1Wf5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NIJsPLV1"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLCjIA4118734
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 05:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DxIV54bZW0mbknxQlawpAwW+
	cPAeEoPsp3aYvzyr9hY=; b=ZB+O1Wf53eu36mBtTwPud49KO9hQowP2gfnqPgwE
	2shvJmDSi8qJt95K4SnQn+tyaY45tCdf4ZJzHSb/H62tfWwBX/py+yXLoG1Aq1ze
	vrGICIKVmH2QZGLg3CXfySNST6xBwDI1l4E+6lOz8Uq6kjDJ1I8iZzMwp7E/CtSl
	notJcVzkiYG0MEc1Dmjezk/FlFAmf47khwLJA9xeJLp1hnS+cPQ94KNNCiY9c0oC
	U7U/GsExkWKnkQvDcRF0aZqXTv7GfOkm4wgsmUtmSp9zk9IUmdQY4Z61fR9b+4+N
	TYENKCzlYJXUcJ6Ub0KcwZ0FD3fYl+H++JFzkgr4z3sLKw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfdd2q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 05:44:46 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1d137a68so20198451cf.3
        for <iommu@lists.linux.dev>; Sun, 16 Aug 2026 22:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786945486; x=1787550286; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DxIV54bZW0mbknxQlawpAwW+cPAeEoPsp3aYvzyr9hY=;
        b=NIJsPLV1GUXMrSbTtU7grRZpldUVxIFx2a/VgwZ2hpY48k6EC/giDtD9yYiSEUeaGm
         ARI3aOLnyScGdXPmTci951W3DfvD8mbYZWA8+qCOq4TPazTW25/ekclPRaWEGIcXcfBs
         DWlOgTSYPP+YD9RBnJjmRpZv16TfO6qeUhy9abqDalFrhYWZQR4+KLd/fdFXSW0WUG96
         UjQkILM8ZIPnalcOETBjW/3S84CqBg/d9QEo+SqaiLCbDFTPX4sEcJdPGGNYG4BN9HJh
         pM+g9+NxSuqeGgwUv21drH3ib7ZvyJ9DnFqWxoI2gJPNbcemC4ackTkZmuQRaPj6GHmf
         Om9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786945486; x=1787550286;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DxIV54bZW0mbknxQlawpAwW+cPAeEoPsp3aYvzyr9hY=;
        b=ivoGX3RMh/dwwou5SY7wZBjAmcemS2yQ4S9wZ2vPG0/lP8n3EUEoJzIZF/cFFQLjl9
         ImNjF9aVaJsr4cT0hZYcT6ye60ffU869IcDNQlLg/0ys5ETpabFcSfFeRr53fILh9BVg
         QnEVw/uq6R6KFomcWmJ71HoQlVwxRQcva2i+LbRMbNOfGYqVCKYBzQUQGzY1gM+cdkBy
         UILw9nNVXFdWyxRNdWZMaErDpBfoz5j90X0U6O5FNrjvJft/hLk6CSDnFGvL4EybrANn
         5V+EBjl92NHpIBVduipdSUM1bFxA3fPc++dZByb3CwBXiwl5HanUOElupSJDWFxLpkLa
         t7/Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro6d8cnhtbVrHeqZbWJJR7s7TWXhPd+5R+ruftdrnBzoy1UAmP0F+gY0P4DoQvW9eP3FeUqsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzl/bHOxtS7cWFDcUiCsErUTxVmoASO3o/SjuNqDdFohkaDB6jZ
	2VdM0FEz3ZmvaIiClKq54IVBIiJANy/ImxlCXGaeBwEiePaJlpT96jV+T4OdTTHhN1TEeelhZio
	jBBo8HoyK90kUOHliYPKd50IZHIlWBGMfW22RJZ7jMKofl5ItnbDdjtogwQ==
X-Gm-Gg: AR+sD13+6yW8HH54Yug3gweqpii2fDAo5rdczJ8GgWAzP9lGKmAfwunaz7V4tsHJApv
	cAAJ1uh5Hy7JQ34W4iNIy3/yGjWQq3ACOREspVsV3S9mS+u5HX36sPsFPrHXcDNuX02yRL0YPmA
	GcjnFVW6jwSU5D3VokJjWzLZmj+BannyMn2121JHkUmQhszYEMrEoa8sa5/NvZL1YdgLoT27fko
	DE7uOyI46xwTd+fA2u9YJK3STWsEZXQC8C3N9jzIMJpfeMNLBR0SP36VGDSg2sI0Bz7gpO+cYjm
	MfYGL3rgyrTi/hfH2w6m9IDoNtPeCKGgqd5/NnBFOVj3qSUzmBNebQvodPDR5LFa0r7APqiwFRU
	zwoTkhSVfQ8OraVZRrbZ6+NHfWTV4o1sZtx4QrK68WtP+VNKl7iWx7V89qKRxPn4OrN74sCz0iH
	8JW/0q9eKdCq+X
X-Received: by 2002:a05:622a:8451:20b0:52d:882e:4986 with SMTP id d75a77b69052e-52d882e4c7emr139157081cf.4.1786945485907;
        Sun, 16 Aug 2026 22:44:45 -0700 (PDT)
X-Received: by 2002:a05:622a:8451:20b0:52d:882e:4986 with SMTP id d75a77b69052e-52d882e4c7emr139156871cf.4.1786945485468;
        Sun, 16 Aug 2026 22:44:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46cffea7bsm89313e87.50.2026.08.16.22.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 22:44:43 -0700 (PDT)
Date: Mon, 17 Aug 2026 08:44:39 +0300
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
Subject: Re: [PATCH v2 15/15] accel/qda: Add remote memory unmap from DSP
 address space
Message-ID: <6k6ogbosxx4z5bh7uriu4fnj24ycuakylq6g2gnuwsbckl2zww@e66jgj5xo52o>
References: <20260817-qda-v2-v2-0-757ab8ed2f64@oss.qualcomm.com>
 <20260817-qda-v2-v2-15-757ab8ed2f64@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-qda-v2-v2-15-757ab8ed2f64@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA0MCBTYWx0ZWRfX2d/wInXOhWE+
 VAnm7RpwildxmXHRwMSym4blj9bzN/2ffgRmHjkAVcx5yF2030b9h3WRNaeqxUxTTwuJRGeyxe7
 vnemOtThVXoCXD6MuxORqOhVcaPNcoE=
X-Proofpoint-ORIG-GUID: 4bxTqC8Cy0GGtXxxO4irHPhazZmJrMtx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA0MCBTYWx0ZWRfXw1Q4N2cHYi5M
 TRubLW5bO3X/CmAAouaXX4oKQ9eESzx8c2/MfaJdtiHoawJBzp0W5izA5l1wnp3aOWvhrclNopf
 E4KbtjE8OjHryjZy+W4MTocdzn0z1Oaxs/QLR+6nhESEGrx2JHhXfksjGGZNk9AqSbzAmh1hmy8
 NBlrjRLYMnm5Q/njV3BvpKe08+SCCHKDW3Bj2URolEjYPoG1CUyMZE/Hk1TnCKZGtOf0zylgZuI
 fFxAkuCmbQq5f97PMo4xzsM9HseQ/mpkE1R4h7U5oZFKVmTqYTYD2vQ2lnwoPKiULpox2DxoZ4r
 bl3PbfZjRVz5BctF8v5QmyqEOCanOZRDeUEY+VIKtiygRaPxiYNngJ9kWcVhpxwQV1qICXbxMFg
 2ZvmIQbkZsvDVkkdoCsWojJN7LCAau7nfOMQASQOmiLpfQjKiiQuFwnin2MbSXd0pD/aVU2xMRj
 sXP7dpUvsw7NKr89jVg==
X-Proofpoint-GUID: 4bxTqC8Cy0GGtXxxO4irHPhazZmJrMtx
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=6a829fce cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=Fyn7aR8NovT3rRngz-oA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170040

On Mon, Aug 17, 2026 at 10:38:45AM +0530, Ekansh Gupta wrote:
> Add DRM_IOCTL_QDA_REMOTE_MUNMAP, which removes a mapping previously
> established with DRM_IOCTL_QDA_REMOTE_MAP from the DSP address space of
> the calling process.
> 
> Mirroring the map path, the DSP exposes two unmap operations, both
> reachable through this IOCTL and selected by the request field of
> struct drm_qda_mem_unmap:
> 
>   QDA_REQUEST_MUNMAP unmaps a region by the DSP address that the
>   corresponding map call returned. It uses the vaddrout and size fields.
> 
>   QDA_REQUEST_MEM_UNMAP unmaps a region by buffer identity, using the
>   GEM handle, the DSP virtual address and the size.

Why do we need two different operations? Can you just pass the GEM
handle to the IOCTL?

Also, what happens if the buffer is still in use on the DSP side? Will
the DSP crash? Will the whole board crash?


> 
> Each request type has its own argument builder in qda_fastrpc.c,
> documented with the packed argument layout the DSP expects. Unknown
> request types are rejected with -EINVAL.
> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/accel/qda/qda_drv.c     |   1 +
>  drivers/accel/qda/qda_fastrpc.c | 119 ++++++++++++++++++++++++++++++++++++++++
>  drivers/accel/qda/qda_fastrpc.h |  34 ++++++++++++
>  drivers/accel/qda/qda_ioctl.c   |  22 ++++++++
>  drivers/accel/qda/qda_ioctl.h   |   1 +
>  include/uapi/drm/qda_accel.h    |  39 ++++++++++++-
>  6 files changed, 215 insertions(+), 1 deletion(-)
> 
> 

-- 
With best wishes
Dmitry
