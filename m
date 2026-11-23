Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464899;
	b=uiKdLG+yaUHX1kIw9rJWlBFSPpAw+JOilScRBOg7CD8NfbwL9SgXoAHHF9+3isbzitAZ
	 vtnzjbankjXiF58gFp1idQewKIMz3juAiDsK7+zljnKOspUmC6GR5cy4q6QeSe+3q/Hlp
	 iY8FrHE/4TJFehv7wiuWdHV9hj25vXKoCzzBOKy57gTcrCYt0NFK5YaXWCNHvwr6Ro8PV
	 upq2fQooXViGJ/5EcVfG8zvmRlr8B7ejps2K5raCYBihlOFE6Ml5bpUHQEITp3cuvXTXF
	 9rmQkqtLnd+Y9X2tTfLsUkE1YzZIkCDfVCdqZDDW+hDhceTMgFBR0YwGGMdhaDntMSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=3iVV+dRSm2zIDxtyL3qbfDnQ9dT1JLFeDEbsWCFcW3Q=;
	b=WgXdxhJyUA7+FNHSu8R7OJ0g+5urt2/zwTToRIrfC7s8NDmRosGvJ3X037pv5x1H7aNC
	 UkWLK1EB1Qdu7m87tddrA0eagmW4wsI4x5P6Hls4A8cge1i2wg8E0xjqzJK3vTzjk+kH9
	 bEGMeavP2mdY5kHT69ir63lNVOUfup1nGgjUJJInipcs/il4n/58B7xKN+94YFv1s95Gq
	 r1xVYyEye6P2+tYLoB+uTL6HtACE+5Mf7+EARowhSCtKBVuaknCSZb2P3nEYiE+xIK0Mv
	 nA0IL7Stf8PzIpWkDtN7pBqCgocKofK0JAjEPZle3kCFQrykr7EbEepycN8MYlVjFoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FBV6E4LN;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9AA606A321
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 20:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A9AA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FBV6E4LN
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1ae7fc5681dso10898c88.1
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 12:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795464898; x=1796069698; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3iVV+dRSm2zIDxtyL3qbfDnQ9dT1JLFeDEbsWCFcW3Q=;
        b=FBV6E4LNJ8br3yRlE4YYF+ydu/KfIPoXGT8GS8TUkYmd1JAFNmqXa1qZ63nuQ/cw6L
         JonthxeiXXl+WBCfQsucN8SBzCPRJU6083Mt/EJoqgBvh3WroGDJ6yQuRGatQd12DA1/
         Yd83tOZRAG3bqIvfIdaxRUI+t+i1IWDitPBzaN8AVXmsy34wiTYM66LzdTOTZP3KVY+j
         Ou061PRgPenvAGFty1r8W112REWPYBaIRlhs3rZxQ5dUBxWD9KRB5/erTuhJTJnXyoUY
         ihEvTvOMC9PPYDmZ/oGDpein8cMHjWSik0FtcClYMKurZwgZe5ZZMEoySzTvdMxTLnHk
         wyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795464898; x=1796069698;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3iVV+dRSm2zIDxtyL3qbfDnQ9dT1JLFeDEbsWCFcW3Q=;
        b=HjfWhXdO6jPDkZAflIaQR8Ld7ksOdLUYwZKH1cB6ytSk/877Utdq2UDy0Ah+W3g4gD
         B5R/Fwf9i08/+0y/6JIarLF8mpsTApAmeT4Z145Cmjtuf5LvCqbogDIPtm6qSOCfD2i3
         AUde4cuBoElkrDsp0iiTCWBv4+odkc1QA+fKMflwEvvB5qDdvvsUs93l+5XTN+04Q0/A
         fWSfDzRUUIifAL5ByGkVZiLK0hZFwSwp5gopzY80+FTznIY9RapxhWKbER61US9SrTO1
         q80GbSjDP0DTu2u+kvd0dM4m1hY0OrwqeWBhfRDGL/OZJZ7Z8Iw3KHRIwpryhrujymL8
         7kEw==
X-Gm-Message-State: APuU4Z/obwtYDPqksWImeqLpvcPZa5x4IGQrf/sA8l7sm60MDw1f5kyU
	ZCrgN4b4CVWATGaL8tH1PGXb07GRLgbJckuB648GElX/QAD49tH3U4XbfAX6rVz4OJyvoD/z76x
	tjobTxg==
X-Gm-Gg: AZFdTZcfxj3TccDIA2VwfEmN4Cp+32PHoymUkx277lHX5W1pGaqsH6fN42NtIkPaMT1
	8iE0+tvsxMdO1sh4+O+oFitY5hq//ZA6ND9i24gkirGF9F51OWh7oibTZxUPa1TNx6M+Wwp+qxl
	fG1G+jhpQ2OR2Gq0RPZaOoEehoJVBwk1dNwTMEMNiGEfulOUVc6N4sHxTe8ggUEFp/DkT8Pcco4
	bKNVwm4+t9v3uPmNbuzyZ6JCdPGvy2vuuL/yU3HfVJRmRfkE72EIcWYhwXZvtcnp8gClBzYWQ3p
	KdREhFlFZFfs7I9sZOCoy+sVOP0dnTD1Kf37HGSk/bd6JCsS/2E7p6X/Ze6dk0XfvyhoYgee2YO
	SKRSznY5M2BgbU7kPPIYMMiq1itjXrihGCotpldrTiMUvj5jCFZxux2vyeDg6lJeSBTavxenGZN
	gvOgpG4m3lmPaUdK0eQ7jAGex/0WLRBdkqplVInNxznxkjPT5oq5YrPzBo+Zlvn6jcNXrJqdT8f
	l1emiZ2yYDXC3zPK/f/dc6T4u/NBBe6A43Tj+aR9aKK5wV18ZZiypGWMg/UvyW6NoMlCGhrHfFZ
	uE8Au3HNDu/+JieJzK37G+IxFi5DcxpJTPjElDwgN+XYGlpVYMxjgUqP+l9II2KU60w=
X-Received: by 2002:a05:701a:cca2:10b0:139:90c3:391b with SMTP id a92af1059eb24-1b56336e369mr2019600c88.1.1795464897663;
        Mon, 23 Nov 2026 12:14:57 -0800 (PST)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm35108129c88.7.2026.11.23.12.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:14:57 -0800 (PST)
Date: Mon, 23 Nov 2026 20:14:52 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Avoid relying on pci_ats_supported() for
 rbtree removal
Message-ID: <awSevGXj59a1gmBA@google.com>
References: <20261123003805.2828580-1-baolu.lu@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123003805.2828580-1-baolu.lu@linux.intel.com>

On Mon, Nov 23, 2026 at 08:38:05AM +0800, Lu Baolu wrote:
> Commit 89436f4f5412 ("iommu/vt-d: Fix WARN_ON in iommu probe path") made
> the device rbtree insertion in intel_iommu_probe_device() conditional on
> pci_ats_supported(). To match, intel_iommu_release_device() only removes
> the device from the rbtree if pci_ats_supported() is still true.
> 
> That relies on pci_ats_supported() returning the same result at release
> as it did at probe. If it changes in between, the rbtree can retain an
> entry after its device_domain_info has been freed, resulting in a
> use-after-free during a later lookup.
> 

FWIW, this already happens today for devices whose ATS is disabled by a
quirk and that are added after the IOMMU notifiers are set up (hot-plug,
VFs): the FINAL fixups clear ats_cap after the IOMMU probe. David's
patch [1] fixes that on the PCI side by moving those quirks to header
fixups, and this patch makes the vt-d side robust regardless, which also
covers Danny's change.

So maybe this (and David's patch) deserve a cc: stable?

> Checking RB_EMPTY_NODE() to track rbtree membership is common in the
> iommu subsystem. Since device_rbtree_remove() safely handles an empty
> node, call it unconditionally in the release path. This makes removal
> depend on the device's actual rbtree membership.
> 
> Fixes: 89436f4f5412 ("iommu/vt-d: Fix WARN_ON in iommu probe path")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

[1] https://lore.kernel.org/all/20261110003353.1824793-1-dmatlack@google.com/
