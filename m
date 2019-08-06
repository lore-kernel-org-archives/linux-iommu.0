Return-Path: <SRS0=bP0W=WC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C8FC433FF
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 22:47:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68CC216F4
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 22:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="V5F2ocdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68CC216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7B577E1F;
	Tue,  6 Aug 2019 22:47:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8E498E1D
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 22:47:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D673782D
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 22:47:47 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id n9so89535066wru.0
	for <iommu@lists.linux-foundation.org>;
	Tue, 06 Aug 2019 15:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=E8l+QFoWuIzZtkfAWu72ZGTXYhrklDytAgz3N4StbaY=;
	b=V5F2ocdtmdaN8wQ++AvKu/Ls+Qa9xYely0fr7vZUfDl1e4SNQMjmfIuKhKN2LPLSjR
	iSVc8kKdORj4on+/JoOq9KmTmaHU2ZR1kwTlmTj3P2KNUI+It8gfmMkW3PZ1ORgnPSxn
	YWvWd0W3NuX3fnVrlvgkTX6ZYFaDMSGkFg7eb3VxWvD3HNZQ5CaYDJPbIJV0KGOU2qBX
	WNxFfsMyEAiwfG4yE2BrBwNfkw6/F2EOKc6kmmV0k3wgDkGJuGu1Npb42ecOzSEgRVHv
	zXm1aoTf7QbNEhDo4Qs/outpOWLYqHh+r4q2cV7lvSeh+GrShsUN8Id53dfbAgAmjSjJ
	vuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=E8l+QFoWuIzZtkfAWu72ZGTXYhrklDytAgz3N4StbaY=;
	b=B63/B8DWyVOYkjt6TYBmZAtFJRVT7MifJcTSSEQfnInEb+xJm4SwjrMlCEV1G8PiIn
	NI+BJfb4qaMyVR3AksVZr8Ehr9K8zLS+7HzLnvVeRrFBTefh7T3/Vj3jNxs5Y/J4Om4n
	wGlY0ach20e21EbXZPMNj8g42IiJsGpapZQXONDqnSoaUEh5D8H2UWp7F6GQ0cRQS+5k
	jhqLlQsLsyGGZrL4UjQDiKv+m+bPE0majybXG/mNGIlzxerh/9Us/Wy293FEsJTwy+On
	qDUaDlnh+WL0RnpgAC5mAsiKruPkIzUrtUnK/A6DlEvLdLvz2Tif0nDLqMJaen1Ok21Q
	x8wQ==
X-Gm-Message-State: APjAAAV659y3tD1xbZasKRiAyJqgbagbSSpZthQK8Lbo0cf90OsVAwdR
	XfQ4KebnHDQm6OvA/tK2ZiG7lugaa4FEJN7ZiQ6WabU4Nu2TANPdP+bFHjgGI0UNb3IoGIvIP94
	r+WmCI5QabZShGMNeIZmh8oYvRoltV5KFGjvxlag/cVJFklBuDFg/R3UnLE5QyQ5lAN8WuivDQg
	fypNcF8/f3D8azC/l4ScodrjhFUReyr5HyjzTL5a18CLCe
X-Google-Smtp-Source: APXvYqxrez9lq0Wa0oDM52d1vpAuR1KM4DLPcp6tbNPmEJRDcwXpvbgvqmpLnHj4dLlbtDU63cIKLw==
X-Received: by 2002:a5d:628d:: with SMTP id k13mr6583026wru.69.1565131666383; 
	Tue, 06 Aug 2019 15:47:46 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
	by smtp.gmail.com with ESMTPSA id
	s3sm93828850wmh.27.2019.08.06.15.47.45
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 06 Aug 2019 15:47:45 -0700 (PDT)
Subject: Re: [PATCH 4.19 17/32] iommu/vt-d: Dont queue_iova() if there is no
	flush queue
To: Pavel Machek <pavel@ucw.cz>
References: <20190802092101.913646560@linuxfoundation.org>
	<20190802092107.177554199@linuxfoundation.org>
	<20190803213453.GA22416@amd>
Message-ID: <dc639510-5d88-5b05-a973-5f4b7c720f76@arista.com>
Date: Tue, 6 Aug 2019 23:47:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190803213453.GA22416@amd>
Content-Language: en-US
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Cc: Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Dmitry Safonov via iommu <iommu@lists.linux-foundation.org>
Reply-To: Dmitry Safonov <dima@arista.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Pavel,

On 8/3/19 10:34 PM, Pavel Machek wrote:
> Hi!
> 
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -3721,7 +3721,7 @@ static void intel_unmap(struct device *d
>>  
>>  	freelist = domain_unmap(domain, start_pfn, last_pfn);
>>  
>> -	if (intel_iommu_strict) {
>> +	if (intel_iommu_strict || !has_iova_flush_queue(&domain->iovad)) {
>>  		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
>>  				      nrpages, !freelist, 0);
>>  		/* free iova */
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -65,9 +65,14 @@ init_iova_domain(struct iova_domain *iov
>>  }
>>  EXPORT_SYMBOL_GPL(init_iova_domain);
>>  
>> +bool has_iova_flush_queue(struct iova_domain *iovad)
>> +{
>> +	return !!iovad->fq;
> 
> Should this be READ_ONCE()?

Why? Compiler can't anyhow assume that it's always true/false and there
is a clear data dependency between this and:
:	queue_iova(&domain->iovad, iova_pfn, nrpages,
:			   (unsigned long)freelist);

> 
>> @@ -100,13 +106,17 @@ int init_iova_flush_queue(struct iova_do
>>  	for_each_possible_cpu(cpu) {
>>  		struct iova_fq *fq;
>>  
>> -		fq = per_cpu_ptr(iovad->fq, cpu);
>> +		fq = per_cpu_ptr(queue, cpu);
>>  		fq->head = 0;
>>  		fq->tail = 0;
>>  
>>  		spin_lock_init(&fq->lock);
>>  	}
>>  
>> +	smp_wmb();
>> +
>> +	iovad->fq = queue;
>> +
> 
> Could we have a comment why the barrier is needed,

I'm up for the comment if you feel like it - in my POV it's quite
obvious that we want finish initializing the queue's internals before
assigning the queue. I didn't put the comment exactly because I felt
like it would state something evident [in my POV].

> and perhaps there
> should be oposing smp_rmb() somewhere? Does this need to be
> WRITE_ONCE() as it is racing against reader?

I feel confused. I might have forgotten everything about barriers, but
again if I'm not mistaken, one doesn't need a barrier in:
: if (A->a != NULL)
:     use(A); /* dereferences A->a */
: else
:     /* don't use `a' */

Thanks,
          Dmitry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
