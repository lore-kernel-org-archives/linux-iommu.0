Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EECBC433F5
	for <iommu@archiver.kernel.org>; Thu, 27 Jan 2022 10:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27C0C41BDA;
	Thu, 27 Jan 2022 10:22:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GsyVBehkEbL5; Thu, 27 Jan 2022 10:22:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 17B6F41BD5;
	Thu, 27 Jan 2022 10:22:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D60C2C0011;
	Thu, 27 Jan 2022 10:22:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B39A3C000B
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 10:22:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B4E940B88
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 10:22:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tJXsUw6XkVDa for <iommu@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 10:22:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 40D2240641
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 10:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643278940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1PmCWGvE0rw+ZGEFxB1GG8/3CTt9oGBb3Q0WVUXx7pM=;
 b=VczalxpzkUEYnBbd9MJix0eQatDPbJAWIyzCYkBBlFn2KCFAB7AqxuLChAkcEJ1C4zsP90
 Cf+D90HezPW4nUGiO0slQxvNnzhB7X8/rsknG5TF+aYs8Lr30zVqxOxQ3O3XR8ghcGEoZI
 tXRh1uYQYmZeGp6+ngpzbPYIwGKgbMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517--pHUm6U3P_uReOfqOdUVDw-1; Thu, 27 Jan 2022 05:22:16 -0500
X-MC-Unique: -pHUm6U3P_uReOfqOdUVDw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 815F41F6B0;
 Thu, 27 Jan 2022 10:22:14 +0000 (UTC)
Received: from starship (unknown [10.40.192.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C50781059119;
 Thu, 27 Jan 2022 10:22:11 +0000 (UTC)
Message-ID: <495878a237748e3652619e692706b9352969f435.camel@redhat.com>
Subject: Re: [PATCH 0/5] iommu/amd: fixes for suspend/resume
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Mike Lothian <mike@fireburn.co.uk>
Date: Thu, 27 Jan 2022 12:22:10 +0200
In-Reply-To: <CAHbf0-EY9_27Tw3v-pfwXDaTuwpsuuFqrJDKZ8C_cW+-PwXwww@mail.gmail.com>
References: <20211123161038.48009-1-mlevitsk@redhat.com>
 <20220125150832.1570-1-mike@fireburn.co.uk>
 <6f0d9b07073ca6d3657500ec076edc1ad2a3e40a.camel@redhat.com>
 <CAHbf0-FJ0c1yAumKCnXLKKFN=tzeJxSd3HyP=dUOBgBTxVG5fw@mail.gmail.com>
 <7809c3253a997330102b9d779206312d6b3bcaf1.camel@redhat.com>
 <CAHbf0-F8Uemcu8FVcZvY0CPOf4kFXOcaCzWF1ZCwkpa3tyut3A@mail.gmail.com>
 <6cf58a4cd925726ef10481d38f9f4e8090f5023d.camel@redhat.com>
 <CAHbf0-EY9_27Tw3v-pfwXDaTuwpsuuFqrJDKZ8C_cW+-PwXwww@mail.gmail.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 tglx@linutronix.de, will@kernel.org, dwmw@amazon.co.uk
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

On Thu, 2022-01-27 at 00:39 +0000, Mike Lothian wrote:
> On Wed, 26 Jan 2022 at 10:12, Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > Great, your system does seem to support GA log
> > (but a patch to check if, other that assume blindly that it is supported is
> > something that should be done).
> > 
> > So could you bump the LOOP_TIMEOUT like by 10x or so and see if the problem goes away?
> > 
> > (that code should be rewritten to time based wait and not just blindly loop like that,
> > I also can prepare a patch for that as well).
> > 
> > Best regards,
> >         Maxim Levitsky
> > 
> 
> Hi
> 
> I've done quite a few restarts with the LOOP_TIMEOUT increased and
> I've not seen the issue since

Great, so the problem is solved I guess. 
Thanks for the help!


I'll send a patch for this in few days to replace this and other similiar timeouts
with a proper udelay() wait.

Best regards,
	Maxim Levitsky

> 
> Cheers
> 
> Mike
> 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
