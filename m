From: "Prem (Premachandra) Mallappa" <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: RE: [PATCH v2 1/2] IOMMU: arm-smmu-v3: Fix broken STE.VALID check
	in Broadcom Vulcan
Date: Sat, 19 Dec 2015 04:47:30 +0000
Message-ID: <CC0BC9CB4553B146B290EC1D4DC5C35901096047@SJEXCHMB15.corp.ad.broadcom.com>
References: <1450346376-30920-1-git-send-email-pmallapp@broadcom.com>
	<20151217114216.GB11456@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151217114216.GB11456-5wv7dgnIgG8@public.gmane.org>
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

Hi Will, 

> 
> Is this workaround only needed for bypass STEs? If not, we have a problem
> when we install a stage-1 entry, because we'll clear the EATS bits as it stands.
>

Yes, this _was_ needed only in Bypass STEs, AFAIK.
However, the h/w fixes that were committed recently has this worked out. 
I have tested and confirmed this patch is no longer necessary. We'll drop this series as STE.VALID is not broken anymore :).

Cheers,
/Prem
