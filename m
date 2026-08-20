Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D5D37475B
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237280; cv=pass; b=JUJ5ABNe8Fj5Kat8MmzqyxId4WRTg8VU7xpgLZ9UxSApqOWd0gid2U8pTT+oZxPGO/4UKnUz7K5iN60tvjMXTRFc9UULKpIDDjtMgpPEe9W4wzafyfdGtQIoCH1m9Zlrnixvy5h0rQkpX7grgZBzZ5+plk0ctDoWgP8UNlI/AiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237280; c=relaxed/simple;
	bh=Tj982Jh94LhkkenOX9KGGw0zBOx2N1w5l+SjfXMkOqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjaICAgl6CGRYYJ9fnyrUTXYO96AkCbI2GlhUqAD9cWpNZqRKhWNViJiNtWyid+6+jvfUhwmw0WVM1gpxdxiqLvb7wBKEa1peMfHH5rieRPK16nt08zDa/J6F27xXcLK3bFvdx6rPiUK3g04DtGjVMDQTTGgTNkpv2Iy9CW2U5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kIlzaYIa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y4NuyDg+; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kIlzaYIa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y4NuyDg+"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KE7XqK3665908
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=yLR4KHznvXfb+H7PWHV2AIGDk1Msa3uBxnhAbjxWO9s=; b=kI
	lzaYIaMnkLJeut0wYrwIzKu5PkJIhncQceAOkWy0QZ+en9V0SahIzZBQ/Wppo6XS
	e2OQQ5dsjGw+/0JN2opJpNdUhvJFbKpEBa4Yuah5jDSD2nB3EMLkmNDZBsY/qOOV
	/uQz6ezGkCfPLaPqCmNE8Yw/T7lIY2GCG7Dur4QGFPGdOqUX4q3ePnNlzPAfd8hg
	w18DDIJ6pn6sBlpf83trCcQyPoUfNxwHqlpgKCOy7oJuJIctvvy46DW3hPkN0x0/
	nqY3CHwpMb6sMB/05dCd8VbDUJuSfzxziFYVVHToUNMt0iCL5l7I0UGfJQ1BitfN
	4YkTEh42f9Ydcsk2BzJQ==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg195f9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:47:57 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-43cd2d12617so3716784fac.3
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 07:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787237277; cv=none;
        d=google.com; s=arc-20260327;
        b=imKrg10/l5pH7KNkO0Q5rSUMfFAFfAjHXHw/gTsRBgQLQ3VhyOnlZYYDxqbgQwqKYK
         W1RwMPJMn/tGj8YEdNc96JgWPorh6MNcO0aZn3kxCYN5Em42KG/akuybcl78YZDONxR6
         32t05Dy41H8knEQRXMU9kQYTBq5fp/VHLKtbVfN7/Zs3ToSVYUFi95VD1pHwkptl5J4h
         Ey1nzXy4BAl9o8U5GwSLXy8+WRXOyH2X7pvV9GSPu/y/wIqZnmZDnitB9m68Xr2gU9rD
         JmcL6zNMgEDFGmy5o60yI5QFPbjx62iMAzlFrELVUM3Kd0rpJHFrbz/JcAyf9z3GpfMb
         3ybg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=yLR4KHznvXfb+H7PWHV2AIGDk1Msa3uBxnhAbjxWO9s=;
        fh=ujysCjgA1mai3DBzeNWMVOtq2wqcfpJRz0rOUC6h6OU=;
        b=P3tgTmpt2sar2TRDWNW0GtPSX//Jtb8L1cZb17TrqaM52exWZvdfFLWLYkeFlDWL35
         SIoNbSmFqw/sZd2UUbFzgqdFdq4h7KDLwKmYPkC62NqhRx7aHHhkThW0SIWD4z5g1hhN
         RAkQbAuN93PAFiCbpjNKsZAlW5E/t6bWvjn/BEX/r+xScm6mdZpP1YNEuV7ZPb/ADFz1
         ax8uH0LaoO5Tb5vzfQrVVRPMt3Qj61QPzTo5jEbmnIqM+pScajhQwG8AojXmNhvjmqwt
         DzD2KipLUfWUmMpSBqyfju+bx3hDwGonrFqOVaPyZLGIYtH/7xm3/hw+TaJfptS8BlV8
         A2dA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787237277; x=1787842077; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yLR4KHznvXfb+H7PWHV2AIGDk1Msa3uBxnhAbjxWO9s=;
        b=Y4NuyDg+4rbJhKdrVKRIWMhrJKLnXWZQRIsqBD2bAhe+U75Dlt/o03aeZTYO3zvZgF
         lPEDRqUJXG2IhFvNYkHRxHUzy7o8t88e5zCFZXTM7C1Do2Rv0XoZUHHL28FD59g9WZEt
         iJ4fneOuAK7Tqf28ioF5OSkXPmEORJQLIYGYHeCJBlvepz8tCbie1Um9CnZCK8hugiUx
         RvCbxBMhD1dWtzzsBEdl0gQ7ZMdr/aV36ZKluOLgvqAASgUEkREJJIdiEr/zWOux9WBE
         8NL79bol7j51i3LGzDjZl2KHbrBgQ9iklSQCvuW95aadNhc1yZoKWfmtjNJhy9TfWnMx
         IuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787237277; x=1787842077;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yLR4KHznvXfb+H7PWHV2AIGDk1Msa3uBxnhAbjxWO9s=;
        b=mz7Vq0xvM92bSm2o+ahPHvN66ML2pVyYU7is/1pYsvl6HB1oHf+s0404hCPzz1eCRu
         UYZBjSSFHyHirLhLynrKXJtuvEPOD+A7ZpgtceRq87IlPOZFMtviRBPSMblQEyIyuab2
         Rpx5wxTWV9fZ1ME+bTIKC7S3BPytEp9KhFaioJCuVR/U8ZrzBRK0SJffC60ZdDLDovtz
         vYd/fSdvNPr9qvpEGlhpG1hg0SfBKd4kvbRMGutgHK2378FDnDm5Wg8VIVUMj0iDzSPJ
         ExC6d7Rza6RrKgstp7iAFUcR4GHqEZ15X5zDmQ0K68HmUhi7NE1lVwWVPDuwWZGT/YeG
         Ed1w==
X-Forwarded-Encrypted: i=1; AHgh+RogjrjjLH5tkJjJguL9PJgTZXNxeLqM9wwT+/a6rBaXvt61N66P+x3MWYhsieAkpkLThNRN9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzP086nz0TARs5e9FdTGbrXiu7ZWIA8I7SrN8ZgepG1vzXMeVby
	3IY944lfBvu1iaXIQKJ7vbh+XD2FbjlelJhuO0gjo2HxQ1hdV/01wH7srtleaYIOerhUDi/rW/h
	lpb6Dy7B3AeIUCHP0q0XLnARsbGHJRG2udTWsJAda4pN5nkIKCdQ1G7NFI0xqkN4FO91n6RFQam
	3g+OntRL4g55NAXXb+/2tCBVpIDoh5KZoG
X-Gm-Gg: AR+sD10vYkAoP7u2/uaqJFzoYVHskEiMJ/RWlcoH+p0eqlXE3+xplA4Q/QIT5ybNG6j
	O1u+Tm78fGHmTg1k230eS5Jf5dMPKQHRsr504bIPTDATA75WdRrHfkcFSRjZiPWNTHv8pdi2xF6
	Erb3OHGNxTmshOfglr6gGHH/82qLwn3ddjxzbExk9u+XCpsXT7MOib5qV2
X-Received: by 2002:a05:6870:718e:b0:457:ed1a:9da3 with SMTP id 586e51a60fabf-462f68b3ee7mr12218578fac.17.1787237276755;
        Thu, 20 Aug 2026 07:47:56 -0700 (PDT)
X-Received: by 2002:a05:6870:718e:b0:457:ed1a:9da3 with SMTP id
 586e51a60fabf-462f68b3ee7mr12218513fac.17.1787237276312; Thu, 20 Aug 2026
 07:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <3322b42b-3755-45ec-ad55-345125f0d488@kernel.org> <10349e29-b583-403f-a89a-9a00c73666bc@oss.qualcomm.com>
 <87dca76c-851e-4cc3-ab91-68949d283b79@kernel.org> <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
 <318f14c2-0e87-4e07-8173-1511dca67d78@kernel.org> <CACSVV01T=ytVJKM7NRoBTAJm7vH+JPJNT9Tftu5X9YskGXerwg@mail.gmail.com>
 <e7b4eceb-cb3a-49ea-bed9-728c958594b0@kernel.org> <CACSVV03ypjBYkhRpt=TyDwOKhejKKke3x=Fi_TvxXN-5U_rCsw@mail.gmail.com>
 <fb834ae5-7113-4a86-bb84-ca5115c8d7ff@kernel.org> <CACSVV018jB4WRRJ_CUHQmkHXZcqauWJXWGgrzY_HA6cFQ+Q3Xw@mail.gmail.com>
 <dd3da35b-1db6-43a4-ae1f-35620692f51f@kernel.org>
In-Reply-To: <dd3da35b-1db6-43a4-ae1f-35620692f51f@kernel.org>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 07:47:45 -0700
X-Gm-Features: AcwNN1UDFgTj8DhU60we-UxrgwU5qCqC53mRJdhnjcqckwpTsRRAswI7otuboc0
Message-ID: <CACSVV01o_XYuSzaYGbo9pY=459qiA_fgL_KRHVJH+LH4RYcMzQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] accel/qda: Qualcomm DSP Accelerator driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: eLh5Uqc6tm3aoeNb4G1qN9cbkaHxD95X
X-Authority-Analysis: v=2.4 cv=G7Is1dk5 c=1 sm=1 tr=0 ts=6a87139d cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=_Q5Bhtsilc8r9Aqu0AoA:9
 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-GUID: eLh5Uqc6tm3aoeNb4G1qN9cbkaHxD95X
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDExMSBTYWx0ZWRfXztb2WeYOdvuR
 8On0+rlBHcPg/m4obmRIZjTAuWqr3q///kSFjc5MCfGabAlADjXtPruOrJ77v9uGtnndCzB/VH+
 /aThyLanHLVE+NMvMEu18KzhGNuYmPw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDExMSBTYWx0ZWRfX19XV5Tg4zfDN
 aYa/FNgWflTNeKRR6l0xm8F+txGYiLif217o1avjyYxjq6pFjn2lIWxPBXeBt/peHN+4QNk5FZ3
 ZyN0Qy14peMWBXmI9JL+MlBXQ9kxh8suXlJeCcyOUtmU3J+VQXDcnF/yOfHRWUm+07UrBXr34kX
 VHoGGDCVxUFBv2+bxbq3hF6PUJ9u7RcXSYLJH7JTlzZtxXAD1wuRscz1z5WQlWphhDlt30vUPT/
 JjTQcQ4tJ9wsUXJJAtz7zUT6GPf9q5XjGdWvAjyltt6v7D6nUG358qBMxVj6wGJGH2aKXySL2to
 qtsx9KOqe2UMUaOoawZJ41xkI0j/UyO2uQp+PK10ToQpl32AQM5tiMH4XVlJDZjlNpaa0zcrSIJ
 14QaANer1ZbMMuuKrk6NAspwrPvbwBjx5FGW95TWoPbINWPBHDXllnRL7Qou3eJ0hAayEj0G78q
 lDFRS9kdraneYhz8oHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200111

On Wed, Aug 19, 2026 at 11:15=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 19/08/2026 17:48, Rob Clark wrote:
> > On Wed, Aug 19, 2026 at 8:27=E2=80=AFAM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >> The rule of usptream development is that we do not accept duplicated
> >> code, just because a vendor wants to write something new. This is
> >> basically the concept applied all over the drivers tree, where we push=
ed
> >> back against all sorts of duplications all over the vendors.
> >>
> >> What I miss in this thread is why would there be any exception here. W=
e
> >> do not grant exceptions from standard practices on "I want" reasons.
> >
> > I agree that we should not have duplicated drivers just for vendor
> > lolz.  But when it comes to adopting common frameworks and integrating
> > better into the ecosystem, this doesn't seem like something we should
> > actively discourage.  I don't think this is a case of vendor lolz, but
>
> No one discourages it. Following standard Linux kernel practices and
> requirements is not discouraging, do not twist the narrative here.
> Again, it is standard upstream review telling that we do not duplicate
> drivers. Ever, unless there is serious exception needed.

I wasn't trying to twist the narrative, just trying to come up with a
path forward that isn't "no" or "improve existing driver", since
neither of those gets us towards a future using common frameworks.

> I asked why there should be an exception granted? Is the reason for
> exception following:
> "We want to adopt common framework"
> ?

Possibly?  But I don't think we want two drivers to be any sort of
long term solution.  (Ie. as long as venus/iris have co-exist.)

>
> > rather reacting to drm/accel emerging as the standard framework for
> > this sort of driver.
> >
> > So how do we get from here to there?
>
> What is wrong with my proposal?

Maybe I missed something, my understanding was your proposal was
"Grow/replace/improve existing driver instead of coming with a
duplicate"..  grow or improve doesn't move us toward common
frameworks.  Maybe "replace" is a valid option.  If there is something
I missed, then I apologize.

Options I can think of are:

1. Hardware cutoff.. new hw gets new driver, existing hw gets existing
   driver
2. Backwards compat chardev registered by new driver, providing existing
   UABI.  I'm not 100% sure about the feasibility/drawbacks of this..
   AFAIU the fastrpc folks where planning a backwards compat layer in
   userspace, so maybe it is possible.
3. exception?

I'd like to know what the feasibility of #2 is, since at a high level
that sounds like the best option.  Possibly limit exposure of legacy
UABI to existing hw so we don't get into a place of needing to extend
the legacy UABI for new hw?

But #1 sounds like a non-controversial place to start regardless.
Possibly with #2 coming as followup and necessary step before eventual
migration to new driver for existing hw?

Even if we start with #2, how do we handle first-merge-window
bugs/regressions without reverting addition of new driver and removal
of old?  It seems like we'd need a window of a couple release cycles
where both drivers exist?

Maybe others have other/better options in mind?

BR,
-R
