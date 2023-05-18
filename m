Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6F23C64
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 12:36:55 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-61a4e03ccbcso17448146d6.2
        for <iommu@lists.linux.dev>; Thu, 18 May 2023 05:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1684413414; x=1687005414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZHehlmJ9aM/l0dubjtOOkzgamyeWee8cpMOepFC//s=;
        b=S/guCeu7QK9uBAUpQW5YPel4p5sO1Rsfe/EMAcJJeDPPabOeBmzrdSsZsC0N6qMG22
         918GVqJgvHnTWXTltvoC0J9StMjLQs8NjDC0Hf/LnCb/sBYYVDBgANMQOD7cjXqB2IHi
         wrkkqqg6mURgV0+9WfEFIgpxJwe+cwLjr8kHGhYxYWmGujGH5Vr4tnKHaap7pI6Klf+3
         PERcxBXz5LQA3GKMTZDjWjnBOjDKAb2gvOUA8eDdHUKDqQaanFfPDXd7X0cy1HnfuYXj
         bZlcfzn/Fs9vRQsnguQt2dfidhsdhZ8rcGre7jAvzhjGsCaHKwzZO9WRBiUutVsgrUYl
         +H6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684413414; x=1687005414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZHehlmJ9aM/l0dubjtOOkzgamyeWee8cpMOepFC//s=;
        b=WlmSannrsHA5nPo3FOs90U+H3rdPzFY+eW95Bf9+gpXaMFhYHhrYkybUgmrG/VCFAf
         V7V5NpY2P0VuxwuWSm7wqkY/hV6kYtcaywMCnnvuxmKjaoufScqBYBqN0aFc/UwqM4La
         9QAhUPwAeWZ0BKygcTQuZ7kbuWzof5+ime3+/o6/nRlZAhEdIDoJMmjb9cOzyHsawmLj
         WmCUSzinnnD4qEzjw2x+/AnhiqWA+aVXx5ahMyqWh2Ql8qwsX9sRJgHw6thqqc/buXwh
         4uoi8vaJoSWsvsByUh1KQm0MDyvaIPs7plcBp9LHNaX5BOF3Urj/MSNtblYeooBBkSgI
         Jjbg==
X-Gm-Message-State: AC+VfDyFrM8TqnGBKcMsqRojwblUzKXeEVerjMVKZ9X92zHWdlmWwHmc
	0Nif9+Maj5BDXSFz/LSwZWwufg==
X-Google-Smtp-Source: ACHHUZ4ALjNvexRyN8fvYtA2j8Eb3UYWss9cY2LgPG0/kcRB1lLHDApvlZyhjit+R/dPaDeAG/5PBA==
X-Received: by 2002:a05:6214:62c:b0:5ef:4254:d6f0 with SMTP id a12-20020a056214062c00b005ef4254d6f0mr4517705qvx.36.1684413414718;
        Thu, 18 May 2023 05:36:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id n18-20020a05620a153200b0075783f6c2b4sm358959qkk.128.2023.05.18.05.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 05:36:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pzcsH-0055on-4J;
	Thu, 18 May 2023 09:36:53 -0300
Date: Thu, 18 May 2023 09:36:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: arm-smmu-v3 sharing SID
Message-ID: <ZGYb5Y1eAgvt/TdY@ziepe.ca>
References: <DU0PR04MB94172CB3F138AD39E9B6DEEF887F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <359b01bc-e87a-9a50-c971-681e89985491@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <359b01bc-e87a-9a50-c971-681e89985491@arm.com>

On Thu, May 18, 2023 at 12:33:25PM +0100, Robin Murphy wrote:

> I'm fairly confident in reasoning about this for basic .attach_dev purposes,
> since I did implement the equivalent for SMMUv2, but I'm not sure I even
> want to think about what it would mean for SVA, PASIDs and nesting...

IIRC we've already taken the approach elsewhere to block PASID if the
group is not singleton.

Jason
