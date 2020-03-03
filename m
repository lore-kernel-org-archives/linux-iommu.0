Return-Path: <SRS0=fiLh=4U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018A8C3F2D7
	for <iommu@archiver.kernel.org>; Tue,  3 Mar 2020 14:02:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1882073D
	for <iommu@archiver.kernel.org>; Tue,  3 Mar 2020 14:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGH2rQ2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1882073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 876B8856F4;
	Tue,  3 Mar 2020 14:02:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5vzJXmNjpxkH; Tue,  3 Mar 2020 14:02:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id ACF9D81EAA;
	Tue,  3 Mar 2020 14:02:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7666CC07FF;
	Tue,  3 Mar 2020 14:02:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62031C07FF
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 14:02:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 58128204FB
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 14:02:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id amDFpfkTTjvA for <iommu@lists.linux-foundation.org>;
 Tue,  3 Mar 2020 14:02:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 92395204E3
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 14:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583244155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vURXmaMa/jNw8/wDeynB3tRJrpHBF8mvDGbk4U2gsFk=;
 b=YGH2rQ2N1Z3+p9W5VsyJjDnVLhH4X1atT5mq4RZpQsrlVtaeUZ3bgrprf4/umFyANWYenT
 dFc/Y32jMHwB0o4aobFThJsu3lmVEE42yzuR5ok/uqrQvzYZM5Bn8V9O7fu7u+/HIVndPv
 f4guKcZ+pNYwl4/wtLKz1Gl6Yn02tMk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-BV9neXLeNbmtRNYmvCAVFw-1; Tue, 03 Mar 2020 09:02:30 -0500
X-MC-Unique: BV9neXLeNbmtRNYmvCAVFw-1
Received: by mail-qt1-f200.google.com with SMTP id g6so2219835qtp.20
 for <iommu@lists.linux-foundation.org>; Tue, 03 Mar 2020 06:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vURXmaMa/jNw8/wDeynB3tRJrpHBF8mvDGbk4U2gsFk=;
 b=l6L9d7CwvlZDfXrjmHxlngJGCdB2aYDMn1dXUeTCpFuH+mOJRSRjuRLkQbqq8Peqs3
 wC/SyByG/DCvH4MkUjs/K+4kKNPxHOwAoJwpb5GoT/mGa7olk4LHThPyt0eejmSA1Zqh
 sgmIBNao2LX0nyfnfQz105T9v4zbQhhZL8BDnDsgeaw23HeIYt3+iO+PAfXVrnbi+guJ
 HYyMxOi5e01F6sD/TbyM32msjUeMnn60ErmwSMAsEg9bsZzSfEm+3vZvkr/073s+jN6/
 5By6U66dL74tMVEyo5ZGQtMUTWm+5hM8XD1bYmjs9FktYe7r5iiktuYzyDvXwts9Rca9
 Ae7w==
X-Gm-Message-State: ANhLgQ1vU+APOwDo/cRfQND+yL9oZMjvEqfox1fPo2EdTFc45lcQEfX8
 H5rUNscfuv3sSpDfSHVkuN1YL7DLLiSjtHff8T1wUKIWm1thLC+1sgTPqPtsVEeUpi/zo+q4yDA
 8+xxSCKpwK1IhN7dhUPGvGmdAbyk1Xw==
X-Received: by 2002:ac8:8d6:: with SMTP id y22mr4331365qth.85.1583244149959;
 Tue, 03 Mar 2020 06:02:29 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsrHkcUNU/JWr3iaSlnrdpMaoXDL9dgR2gjUhWQ2iO+BPmktHURohbRSLr525HkXxY5rlNBXQ==
X-Received: by 2002:ac8:8d6:: with SMTP id y22mr4331328qth.85.1583244149723;
 Tue, 03 Mar 2020 06:02:29 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
 by smtp.gmail.com with ESMTPSA id j7sm8343441qti.14.2020.03.03.06.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 06:02:28 -0800 (PST)
Date: Tue, 3 Mar 2020 09:02:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200303090046-mutt-send-email-mst@kernel.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200302161611.GD7829@8bytes.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 linux-pci@vger.kernel.org, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, bhelgaas@google.com,
 robin.murphy@arm.com
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

On Mon, Mar 02, 2020 at 05:16:12PM +0100, Joerg Roedel wrote:
> On Fri, Feb 28, 2020 at 06:25:36PM +0100, Jean-Philippe Brucker wrote:
> > This solution isn't elegant nor foolproof, but is the best we can do at
> > the moment and works with existing virtio-iommu implementations. It also
> > enables an IOMMU for lightweight hypervisors that do not rely on
> > firmware methods for booting.
> 
> I appreciate the enablement on x86, but putting the conmfiguration into
> mmio-space isn't really something I want to see upstream.

It's in virtio config space, not in mmio-space. With a PCI virtio-IOMMU
device this will be in memory.

> What is the
> problem with defining an ACPI table instead? This would also make things
> work on AARCH64 UEFI machines.
> 
> Regards,
> 
> 	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
