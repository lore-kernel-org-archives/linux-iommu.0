Return-Path: <SRS0=3ib5=D2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957A6C43457
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 14:08:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41D322263
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 14:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NdZ9UN+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41D322263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A46BF87647;
	Mon, 19 Oct 2020 14:08:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8tc75k8fGDCw; Mon, 19 Oct 2020 14:08:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9085C875D8;
	Mon, 19 Oct 2020 14:08:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8332AC0052;
	Mon, 19 Oct 2020 14:08:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88416C0051
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 14:08:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6DE8087646
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 14:08:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qtmC-ABNhuTw for <iommu@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 14:08:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 03536875D8
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 14:08:47 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id md26so14060686ejb.10
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 07:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/KfoISsApaN0NSURJOvvfJb6dwcjjrFUhXMB/UsO5u8=;
 b=NdZ9UN+yHyzobun2pSlu10EnMwdoI5kP57Dg+V9m5zdFRPjXDmTawgoX/3q3hFLOr7
 TR5GP/k/Lp6kZRQsnuow8o3X97atocZ1Gg0S7CVRhxF9sCC+PDl3TXsHlCw5ZYr214ny
 d39+ustjfCO8YQY2hsjzo1g621AuJAVzgi+iHCt05Y95N7+cvHBoiwfmQS5qyExSnd6U
 VNNSXIdBmX7tr2OAhm0mMmhtrkIqePNqGUavbKyC7caHTGUlbxS42DsK58B8keW2wtLJ
 66lBN8ZAkgIhKatEKaGFAMpbsGtj/WH3lUykXJ8SFQGCrlYHkigOufghId9ptnzODJmi
 c9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/KfoISsApaN0NSURJOvvfJb6dwcjjrFUhXMB/UsO5u8=;
 b=FyMC1JPsEwqB6gNTtKr89PCmUpo/1q+6F8iqOIMBcI9TEIgm4q8Xy1nyzzcyJUbkGc
 K2lrX0Et/ujDBtVRCc8IEq5AXYyMgJlF48ELHNNFym2EHhw2CQOSdgbhHPtXYtdn3oPm
 rMaLlCThCEzRaYSdAZtTk0solHm0tbdjoOQBpZDWlIbeWmKM5WdYN6uP9tbrklwKADgH
 XSTwT84NtLLiQrb9d9BzYqv74IUzbDq0YU3MUnB+l/wYeobDtZL837P8U1ZNuMM97w6G
 RHkqrkEdowLbIJZO0l0ToF7vFuZEg1niylaINUUa2g1IZTpnNbXbTQNdWX54eKYkUaiw
 Pncw==
X-Gm-Message-State: AOAM533w7G2TVX2rhsbd2c/Pwh8ZJFnz0+f5QW3Tv+mDn4vzVK21oqLy
 24QiD9bW+d5hqMefAvC/XlSKrA==
X-Google-Smtp-Source: ABdhPJwA7uw6+ZE3RVnaAj9H96KR8FzN4UrEVEZS6aUBgtDdquQPDfuzZYCFSozbMOV5OyjLm10zow==
X-Received: by 2002:a17:906:1150:: with SMTP id i16mr96740eja.82.1603116524907; 
 Mon, 19 Oct 2020 07:08:44 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id f25sm10868868edy.52.2020.10.19.07.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 07:08:44 -0700 (PDT)
Date: Mon, 19 Oct 2020 16:08:24 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [RFC PATCH 0/2] iommu: Avoid unnecessary PRI queue flushes
Message-ID: <20201019140824.GA1478235@myrica>
References: <20201015090028.1278108-1-jean-philippe@linaro.org>
 <20201015182211.GA54780@otc-nc-03>
 <20201016075923.GB1309464@myrica>
 <20201017112525.GA47206@otc-nc-03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201017112525.GA47206@otc-nc-03>
Cc: kevin.tian@intel.com, "Lu, Baolu" <baolu.lu@intel.com>, arnd@arndb.de,
 gregkh@linuxfoundation.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jacon Jun Pan <jacob.jun.pan@intel.com>,
 linux-pci@vger.kernel.org, zhangfei.gao@linaro.org, dwmw2@infradead.org,
 linux-accelerators@lists.ozlabs.org
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

On Sat, Oct 17, 2020 at 04:25:25AM -0700, Raj, Ashok wrote:
> > For devices that *don't* use a stop marker, the PCIe spec says (10.4.1.2):
> > 
> >   To stop [using a PASID] without using a Stop Marker Message, the
> >   function shall:
> >   1. Stop queueing new Page Request Messages for this PASID.
> 
> The device driver would need to tell stop sending any new PR's.
> 
> >   2. Finish transmitting any multi-page Page Request Messages for this
> >      PASID (i.e. send the Page Request Message with the L bit Set).
> >   3. Wait for PRG Response Messages associated any outstanding Page
> >      Request Messages for the PASID.
> > 
> > So they have to flush their PR themselves. And since the device driver
> > completes this sequence before calling unbind(), then there shouldn't be
> > any oustanding PR for the PASID, and unbind() doesn't need to flush,
> > right?
> 
> I can see how the device can complete #2,3 above. But the device driver
> isn't the one managing page-responses right. So in order for the device to
> know the above sequence is complete, it would need to get some assist from
> IOMMU driver?

No the device driver just waits for the device to indicate that it has
completed the sequence. That's what the magic stop-PASID mechanism
described by PCIe does. In 6.20.1 "Managing PASID TLP Prefix Usage" it
says:

"A Function must have a mechanism to request that it gracefully stop using
 a specific PASID. This mechanism is device specific but must satisfy the
 following rules:
 [...]
 * When the stop request mechanism indicates completion, the Function has:
   [...]
   * Complied with additional rules described in Address Translation
     Services (Chapter 10 [10.4.1.2 quoted above]) if Address Translations
     or Page Requests were issued on the behalf of this PASID."

So after the device driver initiates this mechanism in the device, the
device must be able to indicate completion of the mechanism, which
includes completing all in-flight Page Requests. At that point the device
driver can call unbind() knowing there is no pending PR for this PASID.

Thanks,
Jean

> 
> How does the driver know that everything host received has been responded
> back to device?
> 
> > 
> > > I'm not sure about other IOMMU's how they behave, When there is no space in
> > > the PRQ, IOMMU auto-responds to the device. This puts the device in a
> > > while (1) loop. The fake successful response will let the device do a ATS
> > > lookup, and that would fail forcing the device to do another PRQ.
> > 
> > But in the sequence above, step 1 should ensure that the device will not
> > send another PR for any successful response coming back at step 3.
> 
> True, but there could be some page-request in flight on its way to the
> IOMMU. By draining and getting that round trip back to IOMMU we gaurantee
> things in flight are flushed to PRQ after that Drain completes.
> > 
> > So I agree with the below if we suspect there could be pending PR, but
> > given that pending PR are a stop marker thing and we don't know any device
> > using stop markers, I wondered why I bothered implementing PRIq flush at
> > all for SMMUv3, hence this RFC.
> > 
> 
> Cheers,
> Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
