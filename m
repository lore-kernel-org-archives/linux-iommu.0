Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139733D75
	for <iommu@lists.linux.dev>; Tue, 11 Oct 2022 19:42:11 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id nb11so33707329ejc.5
        for <iommu@lists.linux.dev>; Tue, 11 Oct 2022 12:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=extrahop.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y5EKSPZpbhfyCaYVbkZMRUzd2CeuQLvCU74QzaS0Cp8=;
        b=RdsA79ZGuXrTnXeiT1NnpLxRJc2NYyMeCbjMtmP2mx5lda/r80Y7aOX9G4pcNbVqIj
         ZDR9lNhO6cN8wczpuR3qXM91cogeeahe/tOPsOHXSt0atjxfnIgvAQrrBTlxrp59HOKn
         BNPESck9SxVdM+Axf332VoNo76B7vcfXQio9O+6XlfxVVSUM6KfLBb3ItoFF9iakNTHt
         ZKJlveyN1+eGjD/pTzJSpghH8dcpzWwRiWVF9OQ8o2AMMzVCyUX7ezs8ldVOrfuT0GA7
         SLhBrMc6qZ7XhRHcvbS/qkRzxMnAaYjFiQeEgcgEp+BFyfVBqeIwcYpuXbmEa7MUdNxu
         b3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5EKSPZpbhfyCaYVbkZMRUzd2CeuQLvCU74QzaS0Cp8=;
        b=QwWayHR3crABNvul6qyg/Y/GR+sK5R3rDjk8bIyl9VvhTVw5xlqWYHMJ0/iYoosnc6
         cStd8NvL6dWUaUGZn+x8JKt8YYIH0cpU7dn8+94eNV0YDcTJ4JYq1JH/fP0H3f7lTxZN
         0Oq0GnUoqCXiWAfMSmk0ouhzIUp5vp1j5U6TNqqec1AhB2cQ6vbyAaQDbpLC9XO0KZlr
         mpkMpTWlH8QM/+MGDsyP10hW+DOhQI3tFvgcglZP58rytgrxnWYBR7S1JgqACF4Qt4IA
         i1UKN4CIQVna9U+tqIEgzhfh6PX+kt08UFdgSzzoA/xGWGlJUsNxMAtsWhX7JCKISee2
         DcUg==
X-Gm-Message-State: ACrzQf24Ut5HuXdjkcG7jbE+7qyvuemSmH/7fYI6Xqh3bRphTC5CyYoU
	ARSRAG8LY28aAimZhtXsIgb9OBrh75scmgMevtHCvA==
X-Google-Smtp-Source: AMsMyM59e6PjmVE22xOozGxCrbEKrpF2BenfaquuPUqHBJX57o9ft5YIDIGat6ypwSzGh4ruKoSoMA8YPidMW7cpqlU=
X-Received: by 2002:a17:907:a414:b0:78d:e235:5f4e with SMTP id
 sg20-20020a170907a41400b0078de2355f4emr3285518ejc.632.1665517330286; Tue, 11
 Oct 2022 12:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220929044449.32515-1-charlotte@extrahop.com>
 <b03d2ce8-739a-ad53-9cb2-ff09c4ce6f2d@linux.intel.com> <20221010132842.7ptjknebkvhsiqyf@ava.usersys.com>
 <20221010133146.yfd5ywmq7okpbp4a@ava.usersys.com> <CA+N19e6+Qab5qhQOj_QDGU60Ef_V4eJzCydmM_Qa0LGxn8_JvQ@mail.gmail.com>
In-Reply-To: <CA+N19e6+Qab5qhQOj_QDGU60Ef_V4eJzCydmM_Qa0LGxn8_JvQ@mail.gmail.com>
From: Charlotte Tan <charlotte@extrahop.com>
Date: Tue, 11 Oct 2022 12:41:59 -0700
Message-ID: <CA+N19e42MkFO3+oo53hgwpgP_Y28RZr46kB5MDC8ETNi_sKnKw@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: allow NVS regions in arch_rmrr_sanity_check()
To: Aaron Tomlin <atomlin@redhat.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, yian.chen@intel.com, 
	dwmw2@infradead.org, joro@8bytes.org, junichi.nomura@nec.com, 
	Will Mortensen <will@extrahop.com>
Content-Type: text/plain; charset="UTF-8"

Oops, sorry for not using checkpatch.

> No need to send a new version. I will remove the unnecessary parentheses
> (if you agree).

Yep, thanks!

> I will also refine the commit message to avoid long lines.

Yep, please make any other changes as needed.

On Tue, Oct 11, 2022 at 12:39 PM Charlotte Tan <charlotte@extrahop.com> wrote:
>
> > No need to send a new version. I will remove the unnecessary parentheses
> > (if you agree).
>
> Ah sorry I didn't use checkpatch. Yes please make that change and any others to the commit message as needed.
>
> Thanks!
>
> On Mon, Oct 10, 2022 at 6:31 AM Aaron Tomlin <atomlin@redhat.com> wrote:
>>
>> On Mon 2022-10-10 14:28 +0100, Aaron Tomlin wrote:
>> > On Mon 2022-10-10 20:03 +0800, Baolu Lu wrote:
>> > > On 2022/9/29 12:44, Charlotte Tan wrote:
>> > > > diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
>> > > > index 0bef44d30a27..0e99cc1aec08 100644
>> > > > --- a/arch/x86/include/asm/iommu.h
>> > > > +++ b/arch/x86/include/asm/iommu.h
>> > > > @@ -25,8 +25,10 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
>> > > >   {
>> > > >           u64 start = rmrr->base_address;
>> > > >           u64 end = rmrr->end_address + 1;
>> > > > + int entry_type;
>> > > > - if (e820__mapped_all(start, end, E820_TYPE_RESERVED))
>> > > > + entry_type = e820__get_entry_type(start, end);
>> > > > + if ((entry_type == E820_TYPE_RESERVED) || (entry_type == E820_TYPE_NVS))
>> >
>> > Hi Baolu,
>> >
>> > > Thank you for the patch.
>> >
>> > Thank you for the review.
>>
>> Hi Baolu,
>>
>> Please note that I only responded as I offered the Reviewed-by.
>> Indeed, Charlotte's feedback is final.
>>
>>
>> Kind regards,
>> --
>> Aaron Tomlin
>>
>
>
> --
> CHARLOTTE TAN (she/her)
> Principal Software Engineer | Platform & Framework
> ________________________________
> charlotte@extrahop.com
>
>
>


-- 
CHARLOTTE TAN (she/her)
Principal Software Engineer | Platform & Framework
________________________________
charlotte@extrahop.com
