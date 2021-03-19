Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE07C433DB
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 11:17:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF4E64F53
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 11:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF4E64F53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C4FB4ED60;
	Fri, 19 Mar 2021 11:17:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VbbKjZ198DD8; Fri, 19 Mar 2021 11:17:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEED44EBD4;
	Fri, 19 Mar 2021 11:17:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8555EC000A;
	Fri, 19 Mar 2021 11:17:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A0FFC0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 11:17:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3BFE16070B
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 11:17:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rqccjlpifo9y for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 11:17:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D15E606EE
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 11:17:17 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id p19so5254977wmq.1
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 04:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Mx7hOvK9DmxtVp0XCqxXwSfExji8hoKAX6DT7SegFEg=;
 b=jJ0K/jZBT/cLnix4dUAFoQ5NqKJm19Z3dDPbvVYPgIjVDKIp6tq9wV0xqKWc5DnPk9
 oGXVwuJT9K+8SBF4LEYevlQc0R8eKQEj/qVhG62ksgkvAW1Hn7ohliLrRDizbBoHFdk3
 sFwRSO74J/RJS6FpRAY0fPTWtjZAPUECav7QNi7zopW3KB0EgkBNmyishFxBh/6d4DNA
 B1l/lwTrn3ixcO9QS9I3YY06h1kPvnwxSE6bmpSX+ygVSOv8hhQASOcUCp1IgneuvMwL
 05+BlYbt0r7xp0QOjDhXV7vQIvGHj+xf9lvx9T0RPS+yOqxPFwkmECFFHd38JgUj/wMT
 HX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Mx7hOvK9DmxtVp0XCqxXwSfExji8hoKAX6DT7SegFEg=;
 b=PIVE8A8wmOiMeMVGVsYrWtRuFXZ8THaa0LV6SW5BFmsE1z3wej9EumntKfVR/c9d6B
 ia7sklLPowXEX01h0qbKgTFHEjAGZCZ7AvjHoo5jPxkfF+ArO8lLxTHOl/xtGN7vxxHn
 voCN33ScM3OmrL8Wsat0LxMwVZapKKxphj1aerkOQ5YWCTtDAeh2nqwaRqLsrMWFHYd5
 z9eIu6fa2TPKhJEZT4Ye4LhXnBgNAYPWaIHjOzXQOdZ5Ra+cnFK/EPsiB0O4LpHbq/P6
 d767UQk/03qcvyUfWF2u95yF7mcOUKn4LG1mUAe5gW+czEEPqjK2E5Mg+mojS5tEe2Ph
 NORQ==
X-Gm-Message-State: AOAM532iZrg7F9xG+kgyEWzE5g3SwR9LGoku45Ie5yvYe6UDUcBgbGjt
 SYzEQ8n2tx28arNMNSsnp/S+XQ==
X-Google-Smtp-Source: ABdhPJwZHSZ+MF8YNIRa9f/aPijW7SL31SlXsxAA7OsMVyF95Vb6dnP9JfuD+MP7PdUh869HTeSAbw==
X-Received: by 2002:a1c:b783:: with SMTP id h125mr3276508wmf.106.1616152636322; 
 Fri, 19 Mar 2021 04:17:16 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id z2sm7256330wrv.47.2021.03.19.04.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Mar 2021 04:17:15 -0700 (PDT)
Date: Fri, 19 Mar 2021 12:16:57 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH 0/3] Add support for ACPI VIOT
Message-ID: <YFSIKeihQAc8KPmG@myrica>
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
 <e7291605-88ca-6e55-11ec-574b2f94cefa@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e7291605-88ca-6e55-11ec-574b2f94cefa@redhat.com>
Cc: kevin.tian@intel.com, mst@redhat.com, robin.murphy@arm.com,
 rjw@rjwysocki.net, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, will@kernel.org, lenb@kernel.org
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

Hi Eric,

On Fri, Mar 19, 2021 at 11:58:49AM +0100, Auger Eric wrote:
> Hi Jean,
> 
> On 3/16/21 8:16 PM, Jean-Philippe Brucker wrote:
> > Add a driver for the ACPI VIOT table, which enables virtio-iommu on
> > non-devicetree platforms, including x86. This series depends on the
> > ACPICA changes of patch 1, which will be included in next release [1]
> > and pulled into Linux.
> > 
> > The Virtual I/O Translation table (VIOT) describes the topology of
> > para-virtual I/O translation devices and the endpoints they manage.
> > It was recently approved for inclusion into the ACPI standard [2].
> > A provisional version of the specification can be found at [3].
> > 
> > After discussing non-devicetree support for virtio-iommu at length
> > [4][5][6] we concluded that it should use this new ACPI table. And for
> > platforms that don't implement either devicetree or ACPI, a structure
> > that uses roughly the same format [6] can be built into the device.
> > 
> > [1] https://github.com/acpica/acpica/pull/666
> > [2] https://lore.kernel.org/linux-iommu/20210218233943.GH702808@redhat.com/
> > [3] https://jpbrucker.net/virtio-iommu/viot/viot-v9.pdf
> > [4] https://lore.kernel.org/linux-iommu/20191122105000.800410-1-jean-philippe@linaro.org/
> > [5] https://lore.kernel.org/linux-iommu/20200228172537.377327-1-jean-philippe@linaro.org/
> > [6] https://lore.kernel.org/linux-iommu/20200821131540.2801801-1-jean-philippe@linaro.org/
> 
> Do you have a qemu branch to share for us to start exercising different
> kinds of topology?

Yes: https://jpbrucker.net/git/qemu/log/?h=virtio-iommu/acpi
Thanks for the reviews, I'll rework this in a week or so

Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
