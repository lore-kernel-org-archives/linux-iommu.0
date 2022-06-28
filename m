Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C733D6
	for <iommu@lists.linux.dev>; Tue, 28 Jun 2022 14:21:09 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id q6so26025151eji.13
        for <iommu@lists.linux.dev>; Tue, 28 Jun 2022 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AZ1tY/fbYnbotdriO5S1rk84v9dQ1fc1bIXXi25ViSs=;
        b=M4Yy8biplcD6xIbSik7Fcanj3qmtX6uFR9Lkcg9HY9n8g3FbAUo/QCyipVsW7Jci/W
         76nJc0C4Qpa49bHjnodI8YHf+WPa5SaGG+EjfkUFHOKnlUtuQ6CROXVHEuKZnX/CpnBb
         mX6lu4SJJksUAqA5Mt/x2GJW7I+b6qEIW+PXpPA/+w2YWkE+9QRCSUIvYGi5xprrKF9D
         rVQ3kf6SiheUWDlrr/LE0VkX54WLqK4BZIiUu0tzWsts/0WbnNKrk0IqYkokD3unorO7
         V0ZCyCwpJtlkSobho6Ucmi7hZHCLLGDYI8FgiZaC5zhiI7DhrFhYUjIn7/mV5L1eDGZb
         V2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AZ1tY/fbYnbotdriO5S1rk84v9dQ1fc1bIXXi25ViSs=;
        b=IzgV1iHLHJ3UNOJvo+fpIDLqbAoKJXMz6HgbRgIxuKEQy7tbaYEvlKT1CI3sUj4AwL
         Q306NeDIGA4I/qp83Xl43jXf/iT229OhYkHsqhrJXJWYVWIyh7bgY5V0jVUs0G8kiQrG
         DJCVfrW/tZLOx6DDkbk5XCznvBTkZRXwet+ddjNSsjEmkTipeOBSH17xKCK6POGPl/Tm
         0RJeIRlFhP3gWPBc7ACyQMYdoAcpK0kftULMvr2h8YndiC7KVVFIUgjgnqsngefK4btq
         ELxXLJdcbWR53w6TSNGRWhDNW6zM1NK8l0vIAgeGsciTD7H8/K3aLM5hqO8o0qLjxe9O
         T/eA==
X-Gm-Message-State: AJIora/jlFGtAJ1s+1gLCfLFJqFo1NZHHEHEqfEABq9FT+hwhqOvNKaQ
	bOdLh+T06kfW6D70PLf1Ync6Yg==
X-Google-Smtp-Source: AGRyM1vBIfDF8EgzPZnXgOQ5Ii/P2pbYxSeydCSmLWtpDh0bAERdGZisVP2CiMBF+dMiaZzFptnbAw==
X-Received: by 2002:a17:907:8a25:b0:726:c9f2:2f5e with SMTP id sc37-20020a1709078a2500b00726c9f22f5emr4317430ejc.286.1656426067781;
        Tue, 28 Jun 2022 07:21:07 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709061f1000b0071d3b6ed4eesm6518768ejj.160.2022.06.28.07.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:21:07 -0700 (PDT)
Date: Tue, 28 Jun 2022 15:20:43 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
Message-ID: <YrsOO9E+j+CMgKMA@myrica>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
 <faacb997-0c0a-04e1-903d-53857f463214@linux.intel.com>
 <693a3604-d70b-e08c-2621-7f0cb9bdb6ca@linux.intel.com>
 <75b17c70-1658-91ea-0992-1be769550943@linux.intel.com>
 <935ca9e3-28c9-99af-5609-41bb1500b2b3@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <935ca9e3-28c9-99af-5609-41bb1500b2b3@linux.intel.com>
Message-ID: <20220628142043.ivGVse1-0jWi3BZzPejc7eimed91afNrNh1lldFdoAg@z>

On Tue, Jun 28, 2022 at 07:53:39PM +0800, Baolu Lu wrote:
> > > > Once the iopf_handle_single() is removed, the name of
> > > > iopf_handle_group() looks a little weired
> > > > 
> > > > and confused, does this group mean the iommu group (domain) ?
> > > > while I take some minutes to
> > > 
> > > No. This is not the iommu group. It's page request group defined by the
> > > PCI SIG spec. Multiple page requests could be put in a group with a
> > > same group id. All page requests in a group could be responded to device
> > > in one shot.
> > 
> > Thanks your explaination, understand the concept of PCIe PRG.  I meant
> > 
> > do we still have the necessity to mention the "group" here in the name
> > 
> > iopf_handle_group(),  which one is better ? iopf_handle_prg() or
> > 
> > iopf_handler(),  perhaps none of them ? :)
> 
> Oh! Sorry for the misunderstanding.
> 
> I have no strong feeling to change this naming. :-) All the names
> express what the helper does. Jean is the author of this framework. If
> he has the same idea as you, I don't mind renaming it in this patch.

I'm not attached to the name, and I see how it could be confusing. Given
that io-pgfault is not only for PCIe, 'prg' is not the best here either.
iopf_handle_faults(), or just iopf_handler(), seem more suitable.

Thanks,
Jean
