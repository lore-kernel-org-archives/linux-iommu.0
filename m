Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B88848663E
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146651; cv=none; b=kSTtnaPjgn90Mnh8aPOxB6L6kqw1NkgUMuy1I0hv+Z5h7EM25GDZk9GEJ81jsGoT4hOtTW+Cu3MmoeJkDL4r7vRdyC2qlebfeC53MEd3hLmYFQbCGkPV/tmUg9kthN8hrrZlrBxH+rqJz6Fr3hC7PF/v2HokfYCpY8N04UIvrQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146651; c=relaxed/simple;
	bh=1hwayrmSW0iqlDkbTZ+4R/Cn24UtwroEMbSFyV3T3Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVMvqkyHUimRywjr5lJ8bYSeB7YZYMDHPmjQesNSo64Zpf10WvpcvuNtUdGO36JO1e5s3Lii3ynK79cp0A1jluNml5plJv220a7Ey5hcucrANIhbIcCfXA0rEPqOM48xU8F3t9M3Wqh2JgOLvcv+QBxJZrhBbpp1dB1HTTK+HIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FzBEV+AC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YATMsm1c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FzBEV+AC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YATMsm1c"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEmQR9222951
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 17:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=43JV2CT34ywMCqvN1NXrOAtO
	dXSh1XmrnXb+Ch1XFq4=; b=FzBEV+ACGiWF9U3C+hHFMycemyMOgnt8Heo9eeUg
	Xk1dzhykslO7j3yYf79ye1NNrPoGwkZnCbXssagGG/hb6b3Ikxzsw48UiQfMAP1d
	VM8HwcnEnKSdO16IIDZR2rhE8c6fTuSenrhs5zFgwrbee7EHmmztL88hcC9pbrVJ
	tuPsu7g1u440kKLrjWHNLHGpI9TTVNKQFlxRzhaNgEUqWhNJysC7GRf0YZI5gK/w
	gY33dg5Qd+S6Lb6FlwIJPflwEroZRdMXOLJZqHKC+fYewR8giBbmGfCyQ2gtJMdw
	ToM77AlpTgeKgVYll6O/OvNShehart6d8M6SEYoTVwwPkA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbdrav58-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 17:10:47 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-8052a85c6a0so319275a34.0
        for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 10:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789146647; x=1789751447; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=43JV2CT34ywMCqvN1NXrOAtOdXSh1XmrnXb+Ch1XFq4=;
        b=YATMsm1cCW3QdCI6FHmHol9F53ZJAccSfYl37Fl3m2WCbcZ/4c1qSjSUrJbow3PSKa
         BEzgvFTpJHltnpF02hhd16iClaGovtTzJe0iQHcT1LN1QpR2uq/fbFFWtBHOgUkkrbnp
         4BMHmJM4iru+1FYgtYqwrsVJL//zENbj9caI5Tl1fPVJBELHhaOW/cU/fNHlGciKJdls
         TxiK7yT0P/qSVvXNYCuFWR4/KxAYAJDfAFJwoXgeZzBHTj7FXS4crx2uQ1dDfe6fP0GN
         HqvzLMPBj9ed2f5oG7bSnqY+FaBjivXAoP7IKCHvvbcEFD0VLJZPmuzorQorMYrOg79X
         DVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789146647; x=1789751447;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43JV2CT34ywMCqvN1NXrOAtOdXSh1XmrnXb+Ch1XFq4=;
        b=mv43XSGvpxG8VgigSbq/8BvKrYseVMMH0BKfVsTDMONTH4LRB1HoGINd1n7pnmsxoY
         Up0mDr+pfi+kiSOhl1C0BqQW+0HXHNi07yjMfxKK2IDiaYf6BRgNl2CSKtboJVnWsC2A
         eAH691+JKVnnBAGyh81qCazrClPGAs3qlWmZnssIuLpH6Pf72CccfSpcOs3wopr9G+Nn
         WteSwFWTdBEntl1SvZN1KVC1n6cEHhizbvtTpSOa/apfIA2LaPNbNFac160Tg2HkheW+
         xTizvhjF5jDZlHGcD8XoeBSYTEskqt/62MQSmpX7HFqI/n8bExr9l6ZlDBTGAD203nWS
         OozQ==
X-Forwarded-Encrypted: i=1; AKwUvBy7+O0XwWR44pbJmzpU/DV+T9xrC2DlV8XaxuWCYiZxnoIdnrnDz00leqA0O6dyVY6IrvO+EQ==@lists.linux.dev
X-Gm-Message-State: AFuF++li93wOAf6jA9eQTQFP1XjyT82zU6mU0Y0bzf+BgOgofj20QZqJ
	hNIO7163fr1JVfs1Jx43J/f1TWgLbk2PjyFWzG+areJgwGqi4RwOf6e0QCbu3sBHfUiPwDXWp79
	EZABI8c/zxM7GxgPNjGRR9wHrU0+XYZanGQAck9byrvm9SZkS9uYm9K7xfA==
X-Gm-Gg: AYBFou0dtVK4hXKNFVow4DYXRhmz5bxdTcAPVtXjo0kRASA1oAjyR7mgbVbarq3Y50x
	Mq717t4quonZrS0GCX5Xen8J2gBmp59a59oddTYWwfE7jIGaB7DAHEaKYy65IqjmjQ7ugG7VBFL
	Fj5Ud973LBxUMLy32EWLMmewOkpNCHhzUUoCTEteTQnwYo0wqGz/LM/K/ttgZYOsJmhToHchJKj
	NRsVtJA0oUFBdiWjwF4wqctIZVO+5TvEnyCZ61WYc+0vBZXJgkfjanySIbFfRf7H4g82xsu0l2z
	ys+bCRus/mr8BJgc6yEXT8IojKliQdsmn91jvhXhaxeQ/Kt0kB6qcln0/BmpB8GKuK7zfy0+09B
	dXxhhRDsKinlvebMWuRZfCV3clAb+snDBCzm1qyIrWSdhybOhTg==
X-Received: by 2002:a05:6830:81cf:b0:7dc:df37:844b with SMTP id 46e09a7af769-803fadd1e9dmr4468517a34.4.1789146647040;
        Fri, 11 Sep 2026 10:10:47 -0700 (PDT)
X-Received: by 2002:a05:6830:81cf:b0:7dc:df37:844b with SMTP id 46e09a7af769-803fadd1e9dmr4468492a34.4.1789146646681;
        Fri, 11 Sep 2026 10:10:46 -0700 (PDT)
Received: from hu-ashoraj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f59ea2f9sm2763387a34.9.2026.09.11.10.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 10:10:46 -0700 (PDT)
Date: Fri, 11 Sep 2026 10:10:43 -0700
From: Ashok Raj <ashok.raj@oss.qualcomm.com>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
        liam@infradead.org, maple-tree@lists.infradead.org, linux-mm@kvack.org,
        jgg@ziepe.ca, kyle@mcmartin.ca
Subject: Re: [PATCH v5 0/3] iommu/iova: convert from rbtree to maple tree
Message-ID: <aqQ2E68lmU3Fbjsk@hu-ashoraj-lv.qualcomm.com>
References: <20260818152505.1057922-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818152505.1057922-1-riel@surriel.com>
X-Proofpoint-GUID: UlE86586u5CHz_RF26vWonzdya1IMFp4
X-Authority-Analysis: v=2.4 cv=PLmaavqC c=1 sm=1 tr=0 ts=6aa43617 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=fwyzoN0nAAAA:8 a=EUspDBNiAAAA:8 a=nI-UuXyqNnj8uUgxqL4A:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=Sc3RvPAMVtkGz6dGeUiH:22
X-Proofpoint-ORIG-GUID: UlE86586u5CHz_RF26vWonzdya1IMFp4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIzOSBTYWx0ZWRfX4ClJgAwTRZk1
 gMVYqwLSvjk9WR/xNwjWT8cqMlYzkRKvbAHi769RS27ah5pnyBMUMjun9Muq2Jp9IILEU2FLzi2
 /HdKe5so7TkBpFj/vy94Od0Akql7fy8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIzOSBTYWx0ZWRfX0Tr3axKeG4pY
 cEvA78fDMYmg0eP9PrbgqEW3lGI7dOARW+PJkPknvMnUWbgCDjDYXxDb45XINSWh6Vpo0+bmaFD
 i8GooePKM+yFvylXzl2YPVdlMW++v/OEbj62kmrjaqFMhWtWiBgVsm+CLZweW5iHGf2qsGYhYwp
 lsTO0goG2supBOvHl7ot1Hg78YCNLo3CZ6xc6prDNrxDB5lHcarNV74NA9co4JTt+Rl/MZ5IJB8
 vo3stVkavbge1FXx/Ya9WXKqcE3rYoiSM7g1qH++k0T29G/5wuPH/62yMMVt6LYvKstc3KSI60J
 ec2q7gT4h/XuHQcqcY+uZLLBE2fXgO5onceGv/rqPeMBfrbF+SwSn05r0vLWP5ibjwth29El7oX
 K30DkYH5mYnB/HBJqAr8uX9TQ5nVuBvYiX9vDDf0sJ9TsDSWb84pvbNfVJ+7wTRHHHk86o+NQr+
 T2R1UJyp9Qatz/KiX8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110239

On Tue, Aug 18, 2026 at 11:25:00AM -0400, Rik van Riel wrote:
> Occasionally production workloads at Meta run into the linear search in
> alloc_iova() in ways that cause real issues. For example, when enough
> CPUs at a time fall into the linear search trap, systems have been known
> to get stuck for so long that it causes soft lockups.
> 

Something odd, except your cover letter rest of the patches are missing
v5 prefix in your patch? 

> This series indexes the iova ranges in a maple tree instead. Its gap
> search makes alloc_iova() O(log n).
> 
> struct iova loses its rb_node and shrinks from 40 to 16 bytes.
> The maple tree keeps its nodes outside the entries, so total memory
> use ends up about the same as before.
> 
> Patch 2 handles the one thing the maple tree does that an rbtree does
> not: erasing an entry can result in the need to rebalance a tree, and
> allocation of maple tree nodes.
> 
> iovas are freed from atomic context, and GFP_ATOMIC allocations mean
> the erase can fail. When it does, the entry is marked IOVA_DEFERRED
> in place and the struct iova is freed. The marker keeps the range
> reserved until iova_drain_deferred() retries the erase.
> 
> Ashok Raj asked on v4 whether the marker store can fail in turn, since
> the WARN_ON_ONCE there reads like error handling for a case the comment
> claims cannot happen.
> 
> Code examination shows that, with the current maple tree code, the
> IOVA_DEFERRED maple tree store will never result in an allocation,
> and cannot fail. This series adds a test case which allows us to verify
> that maple tree property continues to be true.
> 
> Only a corrupted tree, one no longer holding the iova at its own range,
> can reach a store type that allocates. The WARN_ON_ONCE is more of an
> assertion than a recovery path.
> 
> Liam Howlett's "maple_tree: lock checking and clean ups" series adds a
> WARN_ON_ONCE to mas_nomem() for a GFP_ATOMIC store under an external
> lock. This series is external-lock and GFP_ATOMIC by construction, so
> both stores would splat if that lands as posted.
> 
> Liam, is the intent to disallow that combination, or to flag callers that
> cannot tolerate a failed store? The iova code handles failure on both
> paths.
> 
> The code was written with Claude, and nitpicked by myself. Don't be shy
> if there are more nitpicks remaining.
> 
> Tested with the KUnit suite in a VM, including with PROVE_LOCKING,
> DEBUG_MAPLE_TREE and KASAN enabled, and on an AMD Bergamo system with the
> IOMMU enabled. I know of no way to reproduce the linear search soft
> lockups at will, so that scenario stays unverified in practice.
> 
>  drivers/iommu/.kunitconfig |   6 +
>  drivers/iommu/Kconfig      |  16 +
>  drivers/iommu/Makefile     |   1 +
>  drivers/iommu/iova-kunit.c | 544 +++++++++++++++++++++++++++++++++
>  drivers/iommu/iova.c       | 561 ++++++++++++++++++++---------------
>  include/linux/iova.h       |  21 +-
>  6 files changed, 901 insertions(+), 248 deletions(-)
> 
> ---
> 
> v4: https://lore.kernel.org/r/20260624030853.2340880-1-riel@surriel.com
> 
> v5:
>  - subject prefix iommu/iova:, matching the file's history
>  - put_iova_domain() takes iova_lock across the tree walk and
>    __mt_destroy(); without it lockdep reports suspicious RCU usage,
>    since a MT_FLAGS_LOCK_EXTERN tree checks the external lock
>  - explain why the IOVA_DEFERRED store cannot fail, and check it in
>    test_marker_store_needs_no_node()
>  - deferred erase is now patch 2, the test suite patch 3
>  - rebased onto v7.2-rc8
> v4:
>  - reduce the size of struct iova to 16 bytes
>  - simplify the (hopefully rare) remove_iova GFP_ATOMIC failure path
>  - test case for the deferred free code
> v3:
>  - switch to maple tree (suggested by Robin Murphy)
> v2:
>  - clean up selftests (thanks Jason Gunthorpe)
>  - drop the search-with-alignment, since most iova requests should be
>    of similar sizes, so the worst case behavior is unlikely to hit
>    once ranges are excluded by the augmented rbtree
> 
> base-commit: ad8d485e665829ecbf3c97b22ce251f8ff5f8037

-- 
/ashok.raj
ashok.raj@oss.qualcomm.com
Qualcomm Inc
