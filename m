Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE471798B
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 18:56:53 +0000 (UTC)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-34fcd1b9892so4164645ab.3
        for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695322613; x=1695927413; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nNT2/tTxlFmIxWwqgo/0XCM90wCyMD1PzlNkeutky8A=;
        b=UNNTLVpOz8JvfFkoUB+Ippewu8fgeiQN6s6lZjjCVYzh6tqYEsFTTWbpO2z0bKWpF3
         BLYYZ7jXtwVNRM8xdtQoy3Tq8dpsHUeAuAoJQN3g2yjNI2JNF7gBmXZUn411uddRri61
         1tOU/QcRvBJLqcJrhqCC/OIRlafJ5tNIvNMvbQT4RZEzEVyn8npQYPEammcdJfsizoWN
         1zWUSGNKFRiFFGjWlHgP1NaGXc+DkqHVKsZusmqZzBH44sNZ+9UA39gAWbv0JxyzGiGD
         4GaUxneavOpQ6fWZo4U5jGIvne0vpD1OdefMVLaxIz8z0/u+Y9XBmtYeKMvtnc3ebTp6
         6XcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322613; x=1695927413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNT2/tTxlFmIxWwqgo/0XCM90wCyMD1PzlNkeutky8A=;
        b=dQtec1ghHiKmo/Llb80adgzRswoV2F1bHn8g4G1h+EYE41fUlJMhbmfZTd2WBAtbu6
         I3sVckfU+vJ8E+2cFG5Xt1zL817D7vX+otf7aSxY8aHXvXXXlfmLi+HZgDYGTGMQi8R0
         ow4lbOZosrOAu+G7Llry2Spp4FTlnoC5v0elaEeH/xFbzakv5yAfVWPh/A5FJ4HlDNM2
         TKBlLWuoc52jNj8eNWAWQnKg8HPp++gPjef9jy+KgH18g0WKI7VOdUpSZdMu8Cse9gh1
         hltKQ0Zo9PfFCY7SdWW2LDT78zN98qKfl3rXmbTMCqVtJd7ekpGeVN9OUrD1DHYDcLVg
         scPA==
X-Gm-Message-State: AOJu0YwQYnw/HCrnzFhaSJg4WQ+NYS7y8xxBvX3cNJmMUX8+hV5T2YpH
	AgqBy4vy7Jxp96udYtnX0H29DE6ypPjlGjSqyig=
X-Google-Smtp-Source: AGHT+IEpXdSCS2/x8+X3w0VeAWP4DHLj6wedh+rIY6iO2wK8du2iUVOGQatU5YmHQ+hAKcF5W2XBpQ==
X-Received: by 2002:a05:6e02:1302:b0:34f:c9b4:5f9c with SMTP id g2-20020a056e02130200b0034fc9b45f9cmr6008080ilr.31.1695322611693;
        Thu, 21 Sep 2023 11:56:51 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id y10-20020a63b50a000000b0057412d84d25sm1649420pge.4.2023.09.21.11.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 11:56:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qjOr2-000TTV-F8;
	Thu, 21 Sep 2023 15:56:48 -0300
Date: Thu, 21 Sep 2023 15:56:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tina Zhang <tina.zhang@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] iommu/vt-d: Remove mm->pasid in
 intel_sva_bind_mm()
Message-ID: <20230921185648.GY13795@ziepe.ca>
References: <20230912125936.722348-1-tina.zhang@intel.com>
 <20230912125936.722348-3-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912125936.722348-3-tina.zhang@intel.com>

On Tue, Sep 12, 2023 at 08:59:32PM +0800, Tina Zhang wrote:
> The pasid is passed in as a parameter through .set_dev_pasid() callback.
> Thus, intel_sva_bind_mm() can directly use it instead of retrieving the
> pasid value from mm->pasid.
> 
> Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  drivers/iommu/intel/svm.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I would order this patch first in the series

Jason
