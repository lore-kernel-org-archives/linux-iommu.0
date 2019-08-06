Return-Path: <SRS0=bP0W=WC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55968C31E40
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 23:17:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 260F5214C6
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 23:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="CG5mOnAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260F5214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 97CA0D2E;
	Tue,  6 Aug 2019 23:16:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1E2C5CC6
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 23:16:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B92CB4C3
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 23:16:24 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id l2so78023129wmg.0
	for <iommu@lists.linux-foundation.org>;
	Tue, 06 Aug 2019 16:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Q61qm30k8cg74IhXkTUjHjLeO5mUvURwLoiElUgi8sA=;
	b=CG5mOnAd/KW5rIyYsfrD490hIM61X0WzvKgxKZKRNh1jbjz3QVZzq/BixrHW97Y1bZ
	5bcL6b5ns+9nUsXfNYBhtP1nup+a6bcv+sOsyI+6d78PGJXA+WQojPR+nXuAUKycyODS
	SF8LepmehB+2SnMgqAjYVO/syNqKd47gZ8RS6s7gYrmDvbTUOxzupWz+yoz5SXCmxe9n
	uUWFSm8nyF3ZKPovqDFvymKkg6Wm0AUuBWDYjSWxblYTcoakjOe/3IKGtDwYQHmxqc9Q
	WeRbC4xKJj1kqo/MnRE5WE/Ygbpg6qdGy3sONDN1T+ecuJvl+OlpV1DqSYBSFzXsNDwQ
	C3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Q61qm30k8cg74IhXkTUjHjLeO5mUvURwLoiElUgi8sA=;
	b=Wk2NLOQul30Etchyf2sc21NwyFZcmsdNEHae3XRiRbeREDkMKVjZpmSoW8fVDKpvp2
	BI5USziV+eI0I93xWmE144ctZd2QLLs8lWot8c55Hv8/Oml9l0QcKpO4hJA3HYKostGL
	xvXNyfC7iPffORxvzR0vz+sElZ2YvDoetd3oNY4JRcEA3f99hXkhWBseAILyitGn9kcs
	hTTYGa+4ZrFs/Uw1tPJ2dASoes/8rFLdwFAZnz4QIMH48Y+83Yx7yBCdf6xYwyATxeIm
	DgXQT75BJurb9BsbI0nR72szM+s92K0SgafrMcgm9yqXCQA1hfIZH/HotbkIpkJkSvCO
	+tGg==
X-Gm-Message-State: APjAAAVaDAHYkRZeSzfpM6RyFo9Znoe6e5j4e5G0MynlU1tq9ESp3ic7
	z+rBb5HiQe+v18VPM8xzlaCZO7w38a+pUZgxaHhtWAekd5K1mL3mwYWgMJMvBjIYQqHerrrEjdB
	J0WMqjG1BpdxI036snT1EY73v6c43IRmnEPthbKsKEjln2Q78lvz/ljAodvSo2/vHpxoD9cHG1u
	fpW3N37SKdLWSgv+ELotpqlJGelM6ynjciS93gHAKHmFxB
X-Google-Smtp-Source: APXvYqxZdd7iJIqOekT+GFHNpa0uxjIVasHt3cn+nlZds1B0ydrjr2hGKRtue33c0rK7PgKaL/W/JQ==
X-Received: by 2002:a1c:c545:: with SMTP id v66mr6790710wmf.51.1565133383213; 
	Tue, 06 Aug 2019 16:16:23 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
	by smtp.gmail.com with ESMTPSA id
	o6sm193083319wra.27.2019.08.06.16.16.22
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 06 Aug 2019 16:16:22 -0700 (PDT)
Subject: Re: [PATCH 4.19 17/32] iommu/vt-d: Dont queue_iova() if there is no
	flush queue
To: Pavel Machek <pavel@ucw.cz>
References: <20190802092101.913646560@linuxfoundation.org>
	<20190802092107.177554199@linuxfoundation.org>
	<20190803213453.GA22416@amd>
	<dc639510-5d88-5b05-a973-5f4b7c720f76@arista.com>
Message-ID: <858b5409-d8ed-5ff1-2daf-3f6287fb5c8e@arista.com>
Date: Wed, 7 Aug 2019 00:16:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <dc639510-5d88-5b05-a973-5f4b7c720f76@arista.com>
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

On 8/6/19 11:47 PM, Dmitry Safonov wrote:
> Hi Pavel,
> 
> On 8/3/19 10:34 PM, Pavel Machek wrote:
>> Hi!
>>
>>> --- a/drivers/iommu/intel-iommu.c
>>> +++ b/drivers/iommu/intel-iommu.c
>>> @@ -3721,7 +3721,7 @@ static void intel_unmap(struct device *d
>>>  
>>>  	freelist = domain_unmap(domain, start_pfn, last_pfn);
>>>  
>>> -	if (intel_iommu_strict) {
>>> +	if (intel_iommu_strict || !has_iova_flush_queue(&domain->iovad)) {
>>>  		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
>>>  				      nrpages, !freelist, 0);
>>>  		/* free iova */
>>> --- a/drivers/iommu/iova.c
>>> +++ b/drivers/iommu/iova.c
>>> @@ -65,9 +65,14 @@ init_iova_domain(struct iova_domain *iov
>>>  }
>>>  EXPORT_SYMBOL_GPL(init_iova_domain);
>>>  
>>> +bool has_iova_flush_queue(struct iova_domain *iovad)
>>> +{
>>> +	return !!iovad->fq;
>>
>> Should this be READ_ONCE()?
> 
> Why? Compiler can't anyhow assume that it's always true/false and there
> is a clear data dependency between this and:
> :	queue_iova(&domain->iovad, iova_pfn, nrpages,
> :			   (unsigned long)freelist);
> 
>>
>>> @@ -100,13 +106,17 @@ int init_iova_flush_queue(struct iova_do
>>>  	for_each_possible_cpu(cpu) {
>>>  		struct iova_fq *fq;
>>>  
>>> -		fq = per_cpu_ptr(iovad->fq, cpu);
>>> +		fq = per_cpu_ptr(queue, cpu);
>>>  		fq->head = 0;
>>>  		fq->tail = 0;
>>>  
>>>  		spin_lock_init(&fq->lock);
>>>  	}
>>>  
>>> +	smp_wmb();
>>> +
>>> +	iovad->fq = queue;
>>> +
>>
>> Could we have a comment why the barrier is needed,
> 
> I'm up for the comment if you feel like it - in my POV it's quite
> obvious that we want finish initializing the queue's internals before
> assigning the queue. I didn't put the comment exactly because I felt
> like it would state something evident [in my POV].
> 
>> and perhaps there
>> should be oposing smp_rmb() somewhere? Does this need to be
>> WRITE_ONCE() as it is racing against reader?
> 
> I feel confused. I might have forgotten everything about barriers, but
> again if I'm not mistaken, one doesn't need a barrier in:
> : if (A->a != NULL)
> :     use(A); /* dereferences A->a */
> : else
> :     /* don't use `a' */

And in this simplified example I mean that use() will either see A->a
initialized (IOW, CPU can't load A->a->field1 before checking the
condition) or use() will not be called.

Thanks,
          Dmitry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
