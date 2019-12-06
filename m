Return-Path: <SRS0=JKdE=Z4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52A0C43603
	for <iommu@archiver.kernel.org>; Fri,  6 Dec 2019 05:57:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D0F24689
	for <iommu@archiver.kernel.org>; Fri,  6 Dec 2019 05:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D0F24689
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6FF098816B;
	Fri,  6 Dec 2019 05:57:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bZaATv6c6Mt8; Fri,  6 Dec 2019 05:57:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 935E788672;
	Fri,  6 Dec 2019 05:57:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A7DEC1D7C;
	Fri,  6 Dec 2019 05:57:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46DC2C077D
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 05:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3E5B886506
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 05:57:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jy9GKHWn-iic for <iommu@lists.linux-foundation.org>;
 Fri,  6 Dec 2019 05:57:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1679E87D86
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 05:57:48 +0000 (UTC)
Received: from mail-pf1-f198.google.com ([209.85.210.198])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1id6cb-0005Pz-UE
 for iommu@lists.linux-foundation.org; Fri, 06 Dec 2019 05:57:46 +0000
Received: by mail-pf1-f198.google.com with SMTP id c23so3342059pfn.5
 for <iommu@lists.linux-foundation.org>; Thu, 05 Dec 2019 21:57:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=6QtFl09nSid+JllEcjtMOengdLUy/DcEPJvF+2i249o=;
 b=ESYJH2eLZ2loiwMX+1LCNGLQ7+uog/Kw4t0bYf5yu8y84MwKzFmeUTOEpm9hKvDIF7
 63gBCHNP73Uf2tZU9N3NxUf2J7QSOHAVeE8aw04Ul952A18kHyzsGg3ZPsTkwpbsVmiF
 5E2xLWj1sUxOhMPf1oJJenCnxtgIOfV/bPLW0YnvIPj3sPv1n6HnY1amnPANQYW6p91A
 nr5rIswQy0MHwmbDr9aaOsxHqDEMacc17fAuGjkYLHIA/Y/fRYhOB5oefaxr12r9cUOu
 TqKI0sOKjgULj1GOsfWpUxSH1xIvubsCT8kYCQKl/3VEB4c4IbRCHzeigHTaw2kQFJfE
 devg==
X-Gm-Message-State: APjAAAXzRuMxNw++225nELTcvQjweGKPuqZq59wM94xZT6qbN9JMd5FT
 9/lSQP+6Y14lPMPkZ6Yhl8dFum14aAWyikHtzEyP64VtNaTQQZgtYHrK0qnin4EUOLxinO2hR05
 cBpFkr7T255NYg7uVHTDqiwcremXkIfT+vSP9DuFVWd48BXw=
X-Received: by 2002:a63:4f5c:: with SMTP id p28mr1595531pgl.409.1575611864630; 
 Thu, 05 Dec 2019 21:57:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqxpwzCXZBTrYxhlnFEvhDqo8N995kvpUShDhO5qBE99rEBZ7AsxOo9MkgDPfLC5V9zwBYSYNg==
X-Received: by 2002:a63:4f5c:: with SMTP id p28mr1595519pgl.409.1575611864341; 
 Thu, 05 Dec 2019 21:57:44 -0800 (PST)
Received: from 2001-b011-380f-3c42-d14c-a8f0-9761-234f.dynamic-ip6.hinet.net
 (2001-b011-380f-3c42-d14c-a8f0-9761-234f.dynamic-ip6.hinet.net.
 [2001:b011:380f:3c42:d14c:a8f0:9761:234f])
 by smtp.gmail.com with ESMTPSA id s130sm13560628pgc.82.2019.12.05.21.57.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Dec 2019 21:57:43 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20191202170011.GC30032@infradead.org>
Date: Fri, 6 Dec 2019 13:57:41 +0800
Message-Id: <974A8EB3-70B6-4A33-B36C-CFF69464493C@canonical.com>
References: <20191129142154.29658-1-kai.heng.feng@canonical.com>
 <20191202170011.GC30032@infradead.org>
To: Joerg Roedel <joro@8bytes.org>
X-Mailer: Apple Mail (2.3601.0.10)
Cc: Alex Deucher <alexander.deucher@amd.com>, iommu@lists.linux-foundation.org,
 Kernel development list <linux-kernel@vger.kernel.org>
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

Hi Joerg,

> On Dec 3, 2019, at 01:00, Christoph Hellwig <hch@infradead.org> wrote:
> 
> On Fri, Nov 29, 2019 at 10:21:54PM +0800, Kai-Heng Feng wrote:
>> Serious screen flickering when Stoney Ridge outputs to a 4K monitor.
>> 
>> According to Alex Deucher, IOMMU isn't enabled on Windows, so let's do
>> the same here to avoid screen flickering on 4K monitor.
> 
> Disabling the IOMMU entirely seem pretty severe.  Isn't it enough to
> identity map the GPU device?

Ok, there's set_device_exclusion_range() to exclude the device from IOMMU.
However I don't know how to generate range_start and range_length, which are read from ACPI.

Can you please give me some advice here?

Kai-Henge
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
