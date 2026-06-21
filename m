Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D8C40D588
	for <iommu@lists.linux.dev>; Sun, 21 Jun 2026 00:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782000516; cv=none; b=M39RJu135OhbPTcuHPYLATd0XtTVliVc1ro4L2F9s1lDAuACJI2Od+N+dLXtcgc3DnFvY3NUnDn67V8iwjsMzO5QCl5GqsXbwAIm0p+ZHn8HBcKhS/+zh4256lVB9xpzX3LwiPGyw+lE+xmLnOgFx9kPceRg1HzYSRll4T4RMGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782000516; c=relaxed/simple;
	bh=U4ZsyZ04K1gsvj29IrJlDHEu31J/LNUGosuk9W+iePI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFEO8cGE5B2fDX2hDw2HJ4PM5v4rtEBe+WpT02/R6PJcnERxJONFKr7hG3c8LuUyHQMYtPSRKuNHuunSio26Pob6lWbN8y//I2Mlr/SjsY1GG8puS6/UxFFYhQt0ZGYrzPkLzzAL4xj8lRb2lybQtRP1WDI1roP2N/Qc/AXumqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PrCvxOKN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VP3DjgTS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PrCvxOKN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VP3DjgTS"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65KNrseG819930
	for <iommu@lists.linux.dev>; Sun, 21 Jun 2026 00:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	giTMnft+7U+QSuuNtk/Gaej8IYohIz0BQaKZBI8i7F4=; b=PrCvxOKN5yen8XaO
	ed0/1iodWFHRH98IGJYz+2a0LJDDeyxjYaOZGGK8NyA9GmE+4Je/weE7SfDUCXiL
	rHRZ5Lw6BvYPh65I51zXgHdurBMAe0twJza+uK5X7IERQDpUWnCasKlYgvC1uk1K
	gHy29uROGVGRSCQS3wKhwF4Z3G897SfFfciY5/nd9iTFk+c/pAq3gqZsg/aWFUZC
	pyskf3Q/W3Dx3IVH86srExOeh707vw+/jLj7RJzonccSnXQItfTuPXA506sBtAii
	7Qeobpi85moT80ty7lxtQNDGv7sb4Aw7oKlubzF9+/A5GDU9YzXypYtvZTDwAbJ8
	sJn8gw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewjexsysd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 21 Jun 2026 00:08:28 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1383723dfddso5095190c88.0
        for <iommu@lists.linux.dev>; Sat, 20 Jun 2026 17:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782000507; x=1782605307; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=giTMnft+7U+QSuuNtk/Gaej8IYohIz0BQaKZBI8i7F4=;
        b=VP3DjgTScDEkuNI8FM+hrAIo7k4xL02Z3y2hRheFy/1atLlO65QG9lYVif7d8hs3AV
         kOccu2aVU/94b6dqWz3qd950p+fq1BHJjKZpz8mrFhQ4ykjtyAHvSRwAJ54W2BRHB8AJ
         CTZzO3cTZ5ZPZja4scBfJNM5p5qSVoPCXfyYTlTEVreUta6E0OOdnYGB0IOkIqesUpi7
         PUYQqU/3sN7J/Ai5GKWsaG+8iL6ojNmlD23mQKVMt3qe/II05kFf+TXx2VhQSTGAMdo6
         nMvXTaJtzsqjLvwAu2fvlCl/3JafQpUzyKu8ATD22SoYYLYx53vpdfOHAoW+BYf3+UeU
         7wpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782000507; x=1782605307;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=giTMnft+7U+QSuuNtk/Gaej8IYohIz0BQaKZBI8i7F4=;
        b=qGGE9kntdelrYukYl/7r/KqkJWfU69V+/KJF4S7NFqmNpxTZpqhaAXdDGnryCNSKjR
         ETk7oMe9bFdX9jZxlsa9sv5azq3hULxd+2rxV4Rk9EczfK15ZwV3MPk/lNSjrjhYQLHb
         1IhA0DgAjMRSul62xxkQoUJ/ue+AR/j5pjobB/8C3oEPDUEczuG4xrgfntckKNIlH4lo
         OkmObagVGYjmeYbFKpxSdR+8JziF1DEaAkI+Zl0Bdzkp/i1iC4t2KjiZFyqwGPPgjYIJ
         Ay+DkXYcEgGtZUxJoTzchzcbkDjMKDyha7zMKm/MvjSSRiqsFYZSLVziH7W80UikcvBc
         M9Gg==
X-Forwarded-Encrypted: i=1; AFNElJ/X1GGm9m2xgyyt4+3/FzLqFynlcHCcHbR9XcGr/S1EmbAKhfDSWDIRbVY9RvRNmbldijZefw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwW2/6onPdx9P4XXcrw/ti3KpfnY8chNXNYXr0IBm9xkbUelG1J
	Y0jO6GrIxxzpNZnzbRRna/B/U8sDQwygRHfAW/2Q7W+MGajXi+LEXxVjinSTKrI2WXvFr/t7gSa
	IkZi8CB1ctM/yWjhzdn9gt3wDy4WqxoEUv0HoP4ZguqwTKlVND7EiOaYXMA==
X-Gm-Gg: AfdE7cl8clm9XuwPTAaNGbHkGJiLRJ+A9ajF+vgAjXlvRlRGEZBNA6TY0L6IBVdX+Z5
	3hAM9bqkyChKaESOnKH8axJ+uaavJU1oJeI25SlfA1TdO7KZvWOWZLC6hMDHYncMceIrOMdLdgJ
	FDqDR8P7yiR6lS8SAP+cM3VmpeC8isgZs2WV61L9zYVH802wU5fVx7DbGHkjPecUlzPcdYDx7CM
	/BwWYnOnRryg4jCb1mOJD+jhtgWAmr0z6lE3MUGq/2WvooimpDOf2WAkVdJb5cUJJE1/i4F03rY
	qH22HDh1A2hBn/m8BSNWJ6muiFsRZ1AdFC5/kfSj5YDo3H7BB9k4oCd2/9iIxv03/rULwlXiZhH
	UPNkwWh4epMaLcEmSnth7qRxOWLWg4iKlpXWYMPgjRQlugbdTkgh6anUeWfOp
X-Received: by 2002:a05:7022:ff4b:b0:136:83f5:c80 with SMTP id a92af1059eb24-139a34dbfe6mr4519480c88.4.1782000507243;
        Sat, 20 Jun 2026 17:08:27 -0700 (PDT)
X-Received: by 2002:a05:7022:ff4b:b0:136:83f5:c80 with SMTP id a92af1059eb24-139a34dbfe6mr4519458c88.4.1782000506726;
        Sat, 20 Jun 2026 17:08:26 -0700 (PDT)
Received: from hu-ashoraj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139adcaad8fsm3393425c88.1.2026.06.20.17.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 17:08:26 -0700 (PDT)
Date: Sat, 20 Jun 2026 17:08:24 -0700
From: Ashok Raj <ashok.raj@oss.qualcomm.com>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, robin.murphy@arm.com,
        joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, jgg@ziepe.ca,
        kyle@mcmartin.ca, Rik van Riel <riel@meta.com>,
        "ashok.raj@oss.qualcomm.com" <ashok.raj@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC failure
Message-ID: <ajcreJrgM1iCSzxp@hu-ashoraj-lv.qualcomm.com>
References: <20260603033653.4144138-1-riel@surriel.com>
 <20260603033653.4144138-4-riel@surriel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603033653.4144138-4-riel@surriel.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDI0OSBTYWx0ZWRfX41SO6FTt20Hp
 013voaCB7Q1NMlIc1CeZdjvxt+VT/2tzx/haBL88Q+EhIFZ6HK86kb5EBU+Ja7Jfx43e52U7jYh
 hH4FOFFeV86R7bB6D2e/nXp3vR4TclwAVesoGmL1PYxqsIQI3DSxIREKZcelPVzhdIybr27nr8o
 D9SvJVzRVAIxi2zOA+J5C7Vqy4Qxa9P6rZTTZUDEE07oPKj9vSSciGB6phLtv3roOKRmFkzieMz
 aTxakEJzrWgqasHpzVJY/rrocRsm/jM6IIn24beE65zEBy33l7kgKe9/jOAC31B8UgJo4pGqZX5
 J884yRk2C+RPDNK/51+RuI3fx1f/2/fNBLyt0GmqARytGMzamx/GFaGNfs8lAfHhWCIt+YyY/Vs
 us9NYqzg0PVPag0pViBm9itDLtPXG55+aD5Ui99fvayn7L2bBzEZ6hE0i9vp8aGH87smgeAm4iX
 fUcgvvU4d9233Q7McXw==
X-Proofpoint-ORIG-GUID: ru0pA1QJvQ_oWvKnE47UDBrZQAZXO1nK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIwMDI0OSBTYWx0ZWRfX2ixVnIGcu45h
 UZwhAXgZzg4iWieUJR/ekiMIbrP+upDgrSMNogGqt71/4RvNLYdKzqUK40aEwJUooYCo90gmWaw
 fleQKW6bCgVHYyWSHy5U+ToqPtQw8os=
X-Authority-Analysis: v=2.4 cv=YtA/gYYX c=1 sm=1 tr=0 ts=6a372b7c cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VabnemYjAAAA:8 a=wVPg2usKQdsiY6yO6a0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: ru0pA1QJvQ_oWvKnE47UDBrZQAZXO1nK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606200249

On Tue, Jun 02, 2026 at 11:35:48PM -0400, Rik van Riel wrote:
> From: Rik van Riel <riel@meta.com>
> 

Hi Rik,

I'm a bit rust on these, looking a them after a very long time. So take
my question with a grain of salt :-)


[snip]

> +static void iova_deferred_free_work(struct work_struct *work)
> +{
> +	struct delayed_work *dwork = to_delayed_work(work);
> +	struct iova_domain *iovad = container_of(dwork, struct iova_domain,
> +						 deferred_free_work);
> +	struct llist_node *list = llist_del_all(&iovad->deferred_frees);
> +	struct llist_node *node, *next;
> +
> +	llist_for_each_safe(node, next, list) {
> +		struct iova *iova = container_of(node, struct iova,
> +						 deferred_free);
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&iovad->iova_lock, flags);
> +		if (remove_iova(iovad, iova))
> +			free_iova_mem(iova);
> +		else
> +			llist_add(&iova->deferred_free,
> +				  &iovad->deferred_frees);
> +		spin_unlock_irqrestore(&iovad->iova_lock, flags);
> +	}
> +
> +	if (!llist_empty(&iovad->deferred_frees))
> +		schedule_delayed_work(&iovad->deferred_free_work,
> +				      msecs_to_jiffies(10));

  If remove_iova() keeps failing (mas_store_gfp(NULL, GFP_ATOMIC) still
  can't get a maple tree node), the iova is pushed back onto deferred_frees
  and the work reschedules itself at a flat 10ms — forever.  There is no
  retry counter or no backoff.

  Under sustained memory pressure a device doing frequent unmap could
  accumulate a growing deferred list, exhaust its IOVA space, and start
  failing DMA map calls — with nothing in dmesg pointing at the real cause.

  Should we:

  1. A simple retry counter per iova (or a domain-level counter) with a
     WARN_ONCE after, say, 10 consecutive failures would at least make the
     condition visible.

  2. Exponential backoff (10ms → 50ms → 200ms, capped at e.g. 1s) reduces
     wasted wakeups under sustained pressure without delaying recovery when
     memory frees up quickly.

Cheers,
Ashok
