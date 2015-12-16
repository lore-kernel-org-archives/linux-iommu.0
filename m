From: "Prem (Premachandra) Mallappa" <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: RE: [PATCH] IOMMU: arm-smmu-v3: fix broken S2PS and AARCH64 in
	Broadcom Vulcan
Date: Wed, 16 Dec 2015 10:49:07 +0000
Message-ID: <CC0BC9CB4553B146B290EC1D4DC5C35901094C41@SJEXCHMB15.corp.ad.broadcom.com>
References: <1450110687-32207-1-git-send-email-pmallapp@broadcom.com>
	<20151215134010.GH9452@arm.com>
	<CC0BC9CB4553B146B290EC1D4DC5C35901094BCE@SJEXCHMB15.corp.ad.broadcom.com>
	<20151216101735.GB4308@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151216101735.GB4308-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Jayachandran Chandrashekaran Nair <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> Ok -- so what is the value reported by your IDR5?

Our  IDR5, OAS=0x4 (44bits) 

> 
> Ok, I just didn't see any mention of that in the commit message and wanted
> to make sure it wasn't an accidental unrelated change.
> 
Got it.

/Prem
