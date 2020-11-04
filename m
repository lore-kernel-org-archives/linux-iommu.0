Return-Path: <SRS0=z3hi=EK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA0CC4741F
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 20:56:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5083D207BB
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 20:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWCL1b1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5083D207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B79DC84520;
	Wed,  4 Nov 2020 20:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cp8a1Gzr01-h; Wed,  4 Nov 2020 20:56:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2C74F84514;
	Wed,  4 Nov 2020 20:56:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F202C088B;
	Wed,  4 Nov 2020 20:56:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79644C0051
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 20:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 66960863E8
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 20:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F8xKwCiPECxs for <iommu@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 20:56:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 26DE88627B
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 20:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604523373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ungWZEU+yvjjoS5G8bkpuxo9OeZDZAgv7pFGe3veP9o=;
 b=hWCL1b1aw+rlwwiBn01J9qlsvBqh6tFFS91mo1UaXnvn3ZHZHPcjnzZbxWTxknrpGhMPRK
 pXdnAgRl5ewUvJ/PW0cB6vcH3NjEAf+VVZq6H5NlIjWpx37PXw99/z5ViHfBqmUScG3+pG
 4CDVqZMHgYxnMXLfmML0az/9MM6b+Sw=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-Sc01mq0ZP02fuEVSJvHY9w-1; Wed, 04 Nov 2020 15:56:05 -0500
X-MC-Unique: Sc01mq0ZP02fuEVSJvHY9w-1
Received: by mail-il1-f198.google.com with SMTP id s19so16422496ilb.8
 for <iommu@lists.linux-foundation.org>; Wed, 04 Nov 2020 12:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ungWZEU+yvjjoS5G8bkpuxo9OeZDZAgv7pFGe3veP9o=;
 b=aS+iXHaaMsw9Ex1ElPL4qkRKlHAlQ1jvTRRuruAGylG9j+kcYWp+61ySA0/OA4lBG+
 7H697C1ubaV4Nx57a4Frb2Xyta9PncXaeg9n0KO064mLcEA3HY4Q5q+MGK35S9G0xwfP
 8QwU1qcO9VFSzrVgRuTYrcZUett6rCiXd6/WeIq9Gc6T7XdoehMqDvpL9d+bfBo7YNPz
 u2P7/hpmdRulcOBaoqED8uM+oMcaFriGDqJaCyV6nt6Ew4/xh/75hSV0CDo8+EOrsr7I
 QIQw9pcjPRi0wRhIEEQT/A4eeh6giIYEyUH86zZ/P73Mxh78L+0pU4icNMo/4LxJ20yu
 9uDg==
X-Gm-Message-State: AOAM5338rUOSMd6flHzJabwjUptoK2ToV86ZsH1rzM81SnCOc/2rnK4t
 C7a/aPu+DKUKMulB8n77CCZ7hLGMxuNkEpvWiXv025QNw5A3eTI7En4ZpiYd+DXrPmA/RVVbZxw
 nd2ei9r0Mkog63801f0smFuYrb5Q0zQ==
X-Received: by 2002:a5e:930d:: with SMTP id k13mr18717872iom.33.1604523364844; 
 Wed, 04 Nov 2020 12:56:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9u4/qSIawBf44kt75ww1KZMdwyP+XEBi83reLCrwbrdxCuPZmQOU3/rFLRD3cDEMeh1PFbQ==
X-Received: by 2002:a5e:930d:: with SMTP id k13mr18717853iom.33.1604523364672; 
 Wed, 04 Nov 2020 12:56:04 -0800 (PST)
Received: from localhost (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
 by smtp.gmail.com with ESMTPSA id r14sm1996341ilc.78.2020.11.04.12.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 12:56:03 -0800 (PST)
Date: Wed, 4 Nov 2020 13:56:02 -0700
From: Al Stone <ahs3@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20201104205602.GN1557194@redhat.com>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
 <d54b674e-2626-fc73-d663-136573c32b8a@redhat.com>
 <20201002182348.GO138842@redhat.com>
 <e8a37837-30d0-d7cc-496a-df4c12fff1da@redhat.com>
 <20201103200904.GA1557194@redhat.com>
 <20201104093328.GA505400@myrica>
MIME-Version: 1.0
In-Reply-To: <20201104093328.GA505400@myrica>
User-Agent: Mutt/1.14.6 (2020-07-11)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ahs3@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, kevin.tian@intel.com,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, bhelgaas@google.com, jasowang@redhat.com
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

On 04 Nov 2020 10:33, Jean-Philippe Brucker wrote:
> Hi Al,
> 
> On Tue, Nov 03, 2020 at 01:09:04PM -0700, Al Stone wrote:
> > So, there are some questions about the VIOT definition and I just
> > don't know enough to be able to answer them.  One of the ASWG members
> > is trying to understand the semantics behind the subtables.
> 
> Thanks for the update. We dropped subtables a few versions ago, though, do
> you have the latest v8?
> https://jpbrucker.net/virtio-iommu/viot/viot-v8.pdf

Sorry, I confused some terminology: what are called the Node structures
are implemented as "subtables" in the ACPI reference implementation
(ACPICA).  But yes, I've proposed the v8 version.

> > Is there a particular set of people, or mailing lists, that I can
> > point to to get the questions answered?  Ideally it would be one
> > of the public lists where it has already been discussed, but an
> > individual would be fine, too.  No changes have been proposed, just
> > some questions asked.
> 
> For a public list, I suggest iommu@lists.linux-foundation.org if we should
> pick only one (otherwise add virtualization@lists.linux-foundation.org and
> virtio-dev@lists.oasis-open.org). I'm happy to answer any question, and
> the folks on here are a good set to Cc:
> 
> eric.auger@redhat.com
> jean-philippe@linaro.org
> joro@8bytes.org
> kevin.tian@intel.com
> lorenzo.pieralisi@arm.com
> mst@redhat.com
> sebastien.boeuf@intel.com
> 
> Thanks,
> Jean
> 

Merci, Jean-Philippe :).  I'll point the individual at you and the
iommu mailing list, and the CCs.  Sadly, I did not write down the
full question, nor the person's name (from Microsoft, possibly?)
and now seem to have completely forgotten both (it's been a long
few months...).  If I can find something in the meeting minutes,
I'll pass that on.

Thanks again for everyone's patience.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
