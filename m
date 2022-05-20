Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EFEC433F5
	for <iommu@archiver.kernel.org>; Fri, 20 May 2022 00:25:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B32574255F;
	Fri, 20 May 2022 00:25:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oUbVvGqCCCbO; Fri, 20 May 2022 00:25:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 332B44255D;
	Fri, 20 May 2022 00:25:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA02EC0039;
	Fri, 20 May 2022 00:25:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57AE9C002D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 00:25:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 376CC40125
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 00:25:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q4fwKjJfO5z8 for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 00:25:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E6024000B
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 00:25:10 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id 137so6412433pgb.5
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 17:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=yv36DBCzX/BQaDUaqPNqLF92qej9eDU0JwdcEZTabGk=;
 b=JcWqXFaY/sALkfW1Dx8cAjkIqdWGEUHyQUznTSVbbLbl1mbRMmFY8SuVJfLHUo2De5
 +A9/rvaAd0QTZ0rG2FjtXgzuTMAiK1Yx8cOEW2gdKRx1En7X3z0ifUDGIw9CM/KdQgfI
 adPvR8voG2EFvXZ7e7d8JYB/9LxDXn2ge1AuGmGy16vZFlsIy0r6qXdabjRyjlG8meg2
 mgpbuc/qynMsQSeQE01YRArkFzbCm+b3ik+CMLc/TC4WwOIHVYaDTvo7Fk9ZJ0AJ2E0o
 ot42Ht/JwKLFz5sFS4t0fC4hI0SEf2xZLLZLNrAstbJv5aq665+t25FyqlHwzhrtoj4H
 9q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=yv36DBCzX/BQaDUaqPNqLF92qej9eDU0JwdcEZTabGk=;
 b=8P1g2pul7GCQ7k9AH7jCWmfNxyWQ0L2hLqzellsaGC7B3V4EwNXaii2UXIjPeZ+n/a
 eVR3gqKKdLCC+vK4PdWxmu0VdgG8s+GFHjH8bJM2ybnboc5MiGoQtS+atOX5DbfS/b5U
 +YzocPX/wT7lDirDGWO/RW2efhAKK3JIsn8+RncipKlj422Fet84Amd4fHplbzHNvEXK
 Lt8YKiESr33RNNyxCeu2rKGQ39re5RP5Pef0TrkiycHpGEKiue5qGmcPp4yV4QBwnC3W
 txpO+CFhE6r8B29RLNKiTL89AH8ryAevHhBAOtubitCkLbotYFM25ptgNPWojlBfOxDg
 KYPA==
X-Gm-Message-State: AOAM5339KSYaup3nwD77Ps8lq2Ykkp0S+0xvrZkeFPbrUy/3bjgRD33s
 9lPnYn3gH+MThDlVvPe4A+c=
X-Google-Smtp-Source: ABdhPJztXAbmH6BKWG9SQczKiPGMvBDhoc7zmfBNN5RglBamtXskVMyL+yYcdpdohA8XOXnd0Wwhmw==
X-Received: by 2002:a05:6a00:1a44:b0:510:a043:3b09 with SMTP id
 h4-20020a056a001a4400b00510a0433b09mr7110029pfv.62.1653006310004; 
 Thu, 19 May 2022 17:25:10 -0700 (PDT)
Received: from localhost ([118.208.131.68]) by smtp.gmail.com with ESMTPSA id
 b24-20020a056a0002d800b0050dc76281besm263161pft.152.2022.05.19.17.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 May 2022 17:25:09 -0700 (PDT)
Date: Fri, 20 May 2022 10:25:04 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 20/29] init/main: Delay initialization of the lockup
 detector after smp_init()
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-21-ricardo.neri-calderon@linux.intel.com>
 <1652178524.7j2o02lrl8.astroid@bobo.none>
 <20220513231640.GA9074@ranerica-svr.sc.intel.com>
In-Reply-To: <20220513231640.GA9074@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Message-Id: <1653005608.3e5k2jq3of.astroid@bobo.none>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 Ricardo Neri <ricardo.neri@intel.com>, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Excerpts from Ricardo Neri's message of May 14, 2022 9:16 am:
> On Tue, May 10, 2022 at 08:38:22PM +1000, Nicholas Piggin wrote:
>> Excerpts from Ricardo Neri's message of May 6, 2022 9:59 am:
>> > Certain implementations of the hardlockup detector require support for
>> > Inter-Processor Interrupt shorthands. On x86, support for these can only
>> > be determined after all the possible CPUs have booted once (in
>> > smp_init()). Other architectures may not need such check.
>> > 
>> > lockup_detector_init() only performs the initializations of data
>> > structures of the lockup detector. Hence, there are no dependencies on
>> > smp_init().
>> 
> 
> Thank you for your feedback Nicholas!
> 
>> I think this is the only real thing which affects other watchdog types?
> 
> Also patches 18 and 19 that decouple the NMI watchdog functionality from
> perf.
> 
>> 
>> Not sure if it's a big problem, the secondary CPUs coming up won't
>> have their watchdog active until quite late, and the primary could
>> implement its own timeout in __cpu_up for secondary coming up, and
>> IPI it to get traces if necessary which is probably more robust.
> 
> Indeed that could work. Another alternative I have been pondering is to boot
> the system with the perf-based NMI watchdog enabled. Once all CPUs are up
> and running, switch to the HPET-based NMI watchdog and free the PMU counters.

Just to cover smp_init()? Unless you could move the watchdog 
significantly earlier, I'd say it's probably not worth bothering
with.

Yes the boot CPU is doing *some* work that could lock up, but most 
complexity is in the secondaries coming up and they won't have their own 
watchdog coverage for a good chunk of that anyway.

If anything I would just add some timeout warning or IPI or something in
those wait loops in x86's __cpu_up code if you are worried about 
catching issues here. Actually the watchdog probably wouldn't catch any
of those anyway because they either run with interrupts enabled or
touch_nmi_watchdog()! So yeah that'd be pretty pointless.

Thanks,
Nick
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
