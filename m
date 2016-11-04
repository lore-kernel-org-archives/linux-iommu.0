From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH] iommu: arm-smmu: Set SMTNMB_TLBEN in ACR to enable
	caching of bypass entries
Date: Fri, 4 Nov 2016 03:52:16 +0000
Message-ID: <DB6PR0402MB269406338DF2031277884F44E6A20@DB6PR0402MB2694.eurprd04.prod.outlook.com>
References: <1478219244-7815-1-git-send-email-nipun.gupta@nxp.com>
	<VI1PR0401MB263890564BC836B7BBE744018DA30@VI1PR0401MB2638.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <VI1PR0401MB263890564BC836B7BBE744018DA30-9IDQY6o3qQjcXZ0H4ZLnAo3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Stuart Yoder
> Sent: Friday, November 04, 2016 2:27
> To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>; robin.murphy-5wv7dgnIgG8@public.gmane.org;
> will.deacon-5wv7dgnIgG8@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Cc: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> Subject: RE: [PATCH] iommu: arm-smmu: Set SMTNMB_TLBEN in ACR to enable
> caching of bypass entries
> 
> 
> 
> > -----Original Message-----
> > From: Nipun Gupta [mailto:nipun.gupta-3arQi8VN3Tc@public.gmane.org]
> > Sent: Thursday, November 03, 2016 7:27 PM
> > To: robin.murphy-5wv7dgnIgG8@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org;
> > linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> > foundation.org
> > Cc: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>; Nipun Gupta
> > <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> > Subject: [PATCH] iommu: arm-smmu: Set SMTNMB_TLBEN in ACR to enable
> > caching of bypass entries
> 
> When you respin a patch, put the version number in the patch subject:
> 
>    [PATCH v2] iommu: arm-smmu: Set SMTNMB_TLBEN in ACR to enable caching
> of bypass entries

I added that first, but in the last moment used git format-patch after minor updates
and somehow missed it in the final patch :/. Re-spinning v3 with correct version number.

Thanks,
Nipun

> 
> Stuart
