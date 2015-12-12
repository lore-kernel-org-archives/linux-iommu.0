From: "Prem (Premachandra) Mallappa" <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: RE: [PATCH] IOMMU: arm-smmu-v3: Use STE.S1STALLD only when supported
Date: Sat, 12 Dec 2015 05:31:12 +0000
Message-ID: <CC0BC9CB4553B146B290EC1D4DC5C359010946B3@SJEXCHMB15.corp.ad.broadcom.com>
References: <1447663700-13309-1-git-send-email-pmallapp@broadcom.com>
	<20151117174636.GO30101@arm.com>
	<CC0BC9CB4553B146B290EC1D4DC5C359010924D5@SJEXCHMB15.corp.ad.broadcom.com>
	<20151211195301.GA11096@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151211195301.GA11096-5wv7dgnIgG8@public.gmane.org>
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
It is ready, in internal review, will be sending it in a day.

/Prem

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon-5wv7dgnIgG8@public.gmane.org]
> Sent: 12 December 2015 01:23 AM
> To: Prem (Premachandra) Mallappa
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> Jayachandran Chandrashekaran Nair
> Subject: Re: [PATCH] IOMMU: arm-smmu-v3: Use STE.S1STALLD only when
> supported
> 
> Hi Prem,
> 
> On Tue, Nov 24, 2015 at 05:30:37AM +0000, Prem (Premachandra) Mallappa
> wrote:
> > Thanks for comments, I was on holiday, I'll send updated patch along with
> > 2 more soon.
> 
> Any update on this patch?
> 
> Cheers,
> 
> Will
