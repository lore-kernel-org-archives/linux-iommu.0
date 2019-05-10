Return-Path: <SRS0=MPmd=TK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C82C04A6B
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 18:23:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8606E217D6
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 18:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JU7a3v7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8606E217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5908FDB3;
	Fri, 10 May 2019 18:23:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 889C45AA
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 18:23:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DE8DBCF
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 18:23:46 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id w33so6282672edb.10
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=dra68sD3A+L9jmTIge40RbJUDi0r64rvVKFCcIo9SWw=;
	b=JU7a3v7RiEPD0VNYuvo2kA58OUV7CQec5Ky0+jiMqZlny9/CBjNNYq4moEr1fX4pk5
	Vl39VkY8/uNJsv3AmfCAB4yL/naqG1CR4VS8IBCruJAiFmJCq4PKyMcGsojx3eOxbB0I
	VGRmjtXGeVK6pCln5OuvJUVLngWjz9mng9/csQqQcVukvSUlw7G3behUihBvp/Q6dYQM
	KpD/fVa/3uGUf3NHOIvyS6PB5ehNdGETjupUhRA6M7U5KJOknptkLUIivQx2ur907mKN
	UkkhhgRONlVmFckixCjsCppo6REXgRk/ORQlUjmFMCPVZ3yvauhqYRex1VQau3q+Te27
	77yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=dra68sD3A+L9jmTIge40RbJUDi0r64rvVKFCcIo9SWw=;
	b=ZVNYOKbfSmyTVrfszNRXo2eZA7Ls4eRUi3QVu9VBAcH7W42Jj2eC8A/7psvJp2gFq8
	dx+w2gNj/M3WN59WymOuCLO9xqm9pVvLpZESgJAgS+CXSjykzRaRtuicSpx1ApBF9ClM
	l8MFku/KCCknHodnZSlcO4LwRVxQbf2uc6ICFArP2SrMqpWW4DGU/q3hZnJwcu6B305n
	w0po5yF1KiqNVui5OhD7vabB3RKyYjh3yYYn7LmHaF/Gu2lgveHwmiAWkrolCvvdgdB/
	smqRJMiEtxYHZw+ih+AtgjTCLk2FVbh0uLuIqetC33tNdrvwrqsqgIr4FTpgJprJjJFq
	bIsQ==
X-Gm-Message-State: APjAAAUOrwcnJhV7G8nO/3PQgEdD5+7zjIVmwzYSgcqGK90NuiDLExmi
	LwFV+KlksB0uWKuhjYig5OP6dyM1dXsxNCHZjoI=
X-Google-Smtp-Source: APXvYqzRQiFqm/l2aMVgEBwFQ5yK/wNMJvVmyhgygOk1zEL5AYR7ciH6/liicBqcTNkP12Ulkw8VgOjDuH6k3s3Qgm4=
X-Received: by 2002:a50:b3a6:: with SMTP id s35mr13324855edd.220.1557512625336;
	Fri, 10 May 2019 11:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20170914194444.32551-1-robdclark@gmail.com>
	<20170919123038.GF8398@8bytes.org>
	<CAF6AEGuutkqjrWk4jagE=p-NwHgxdiPZjjsaFsfwtczK568j+A@mail.gmail.com>
	<20170922090204.GJ8398@8bytes.org>
	<32e3ab2c-a996-c805-2a0d-a2e85deb3a50@arm.com>
In-Reply-To: <32e3ab2c-a996-c805-2a0d-a2e85deb3a50@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 10 May 2019 11:23:35 -0700
Message-ID: <CAF6AEGuepdKo1Ob2jW66UhYXOTAqOMc3C-XKsK3Rze1QdLobLw@mail.gmail.com>
Subject: Re: [RFC] iommu: arm-smmu: stall support
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Will Deacon <Will.Deacon@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Sep 22, 2017 at 2:58 AM Jean-Philippe Brucker
<jean-philippe.brucker@arm.com> wrote:
>
> On 22/09/17 10:02, Joerg Roedel wrote:
> > On Tue, Sep 19, 2017 at 10:23:43AM -0400, Rob Clark wrote:
> >> I would like to decide in the IRQ whether or not to queue work or not,
> >> because when we get a gpu fault, we tend to get 1000's of gpu faults
> >> all at once (and I really only need to handle the first one).  I
> >> suppose that could also be achieved by having a special return value
> >> from the fault handler to say "call me again from a wq"..
> >>
> >> Note that in the drm driver I already have a suitable wq to queue the
> >> work, so it really doesn't buy me anything to have the iommu driver
> >> toss things off to a wq for me.  Might be a different situation for
> >> other drivers (but I guess mostly other drivers are using iommu API
> >> indirectly via dma-mapping?)
> >
> > Okay, so since you are the only user for now, we don't need a
> > work-queue. But I still want the ->resume call-back to be hidden in the
> > iommu code and not be exposed to users.
> >
> > We already have per-domain fault-handlers, so the best solution for now
> > is to call ->resume from report_iommu_fault() when the fault-handler
> > returns a special value.
>
> The problem is that report_iommu_fault is called from IRQ context by the
> SMMU driver, so the device driver callback cannot sleep.
>
> So if the device driver needs to be able to sleep between fault report and
> resume, as I understand Rob needs for writing debugfs, we can either:
>
> * call report_iommu_fault from higher up, in a thread or workqueue.
> * split the fault reporting as this patch proposes. The exact same
>   mechanism is needed for the vSVM work by Intel: in order to inject fault
>   into the guest, they would like to have an atomic notifier registered by
>   VFIO for passing down the Page Request, and a new function in the IOMMU
>   API to resume/complete the fault.
>

So I was thinking about this topic again.. I would still like to get
some sort of async resume so that I can wire up GPU cmdstream/state
logging on iommu fault (without locally resurrecting and rebasing this
patch and drm/msm side changes each time I need to debug iommu
faults)..

And I do still prefer the fault cb in irq (or not requiring it in
wq)..  but on thinking about it, the two ideas aren't entirely
conflicting, ie. add some flags either when we register handler[1], or
they could be handled thru domain_set_attr, like:

 _EXPLICIT_RESUME - iommu API user calls iommu_domain_resume(),
potentialy from wq/thread after fault handler returns
 _HANDLER_SLEEPS  - iommu core handles the wq, and calls ops->resume()
internally

In both cases, from the iommu driver PoV it just implements
iommu_ops::resume().. in first case it is called via iommu user either
from the fault handler or at some point later (ie. wq or thread).

I don't particularly need the _HANDLER_SLEEPS case (unless I can't
convince anyone that iommu_domamin_resume() called from outside iommu
core is a good idea).. so probably I wouldn't wire up the wq plumbing
for the _HANDLER_SLEEPS case unless someone really wanted me to.

Since there are more iommu drivers, than places that register fault
handlers, I like the idea that in either case, from the driver PoV, it
is just implementing the resume callback.

[1] currently I only see a few places where fault handlers are
registered, so changing iommu_set_fault_handler() is really not much
churn

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
