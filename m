Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B49C433DF
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 08:41:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8908E20723
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 08:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ia9cBwKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8908E20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5D63187D80;
	Wed, 27 May 2020 08:41:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9OiMt1XLsavH; Wed, 27 May 2020 08:41:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D2D43878A8;
	Wed, 27 May 2020 08:41:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC623C0881;
	Wed, 27 May 2020 08:41:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2F33C016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 08:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E160786135
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 08:41:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gAEKGvV-2re2 for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 08:41:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id ED1B385FDB
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 08:41:49 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id t18so9087670wru.6
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 01:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=hUudrY4n5TJoRLFYuGbnj/ynP3kKZ6PzeqLLC1Y9vLY=;
 b=Ia9cBwKnBLKCJMYaauUNF25v0ARnU70yfbKeUOBTph0+Xzje83jRJxDwcPs61lucVY
 IcB3WVN9vt1X/h3OvxEedOJ9r69WYev2C33H65K5FiKsnDdJqJLpq8RNTKksXa0rOcnz
 TxBO57dh+LWIuBsT0tFvMwr9lfykO/Tw/jvKKVARPZHH08mhL27nholqnUcfKnX7mgD1
 iAse1MiKVAqA41m28BnS+Lv+Dj44WS5o5BUQMS0bj0a97mECUb658E7ah2hiOIGNhkHK
 IPmDG9nI4cB6d8N1P9wtVe27q96mQyW6JoEQFCTkWRFPees5a7dJC7FeQKEpnL7bZ1Es
 ZdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hUudrY4n5TJoRLFYuGbnj/ynP3kKZ6PzeqLLC1Y9vLY=;
 b=FTJdDCKXFL046ao0qQChwHDrMdwnwNlXsKGBwTEA15emqMjp/A7ORTmbpOBB/ibv90
 XlVifIVrbuPlopxrK35tW4+MCup+Jglm37vAo8CK20zYFtX0UXY7Oo5u0EJKaO0YSpht
 tGSVwLnDser50P1FtSAMAZJR7KiAjjQDaFquqwMNtxEKiW5fPGYQM+YK85qM59kaXGFz
 GNGK8zopnB205CVyWYECGRGJ975eufkbHwBxJ1PLCVIFHgR0bdqHI8sHzEOsIqJtKCGP
 pfLI7+XXTWOIBiIj63r1U1JF9LdgNLP8QzMadWFAV/bZKlJXONhTufCjzzrg9rXouENP
 2EjA==
X-Gm-Message-State: AOAM533gEr6vwnLirxEMEiM8JUXtnJ7CfFuot2WQOSFosj/+R9pBq9eR
 /frSEvI6/AS5KIo0WAw0k9mI9A==
X-Google-Smtp-Source: ABdhPJzqoGf6Z/QRASvsBBJ7Mi/1v+DHuWG7VFZ92LMFBPICZDognl6udyMXUL6BbimKw34o0Uo6Ag==
X-Received: by 2002:a05:6000:10cf:: with SMTP id
 b15mr23239941wrx.214.1590568908454; 
 Wed, 27 May 2020 01:41:48 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id q1sm2208428wmj.9.2020.05.27.01.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 01:41:47 -0700 (PDT)
Date: Wed, 27 May 2020 10:41:37 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Xiang Zheng <zhengxiang9@huawei.com>
Subject: Re: [PATCH v7 18/24] iommu/arm-smmu-v3: Add support for Hardware
 Translation Table Update
Message-ID: <20200527084137.GA265288@myrica>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-19-jean-philippe@linaro.org>
 <4eea10e0-1343-8d7d-ba8d-214d05558c76@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4eea10e0-1343-8d7d-ba8d-214d05558c76@huawei.com>
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, will@kernel.org,
 fenghua.yu@intel.com, jgg@ziepe.ca, linux-pci@vger.kernel.org,
 christian.koenig@amd.com, hch@infradead.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Wang Haibin <wanghaibin.wang@huawei.com>,
 catalin.marinas@arm.com, zhangfei.gao@linaro.org, robin.murphy@arm.com,
 felix.kuehling@amd.com, linux-arm-kernel@lists.infradead.org
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

On Wed, May 27, 2020 at 11:00:29AM +0800, Xiang Zheng wrote:
> Hi Jean,
> 
> This patch only enables HTTU bits in CDs. Is it also neccessary to enable
> HTTU bits in STEs in this patch?

Only if you need HTTU for stage-2 tables. This series is only about
sharing stage-1 page tables, for which HTTU is enabled in the CD. I'll add
a statement in the commit message.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
