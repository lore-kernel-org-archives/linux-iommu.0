From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 5/5 v9] iommu/fsl: Freescale PAMU driver and iommu
	implementation.
Date: Mon, 18 Mar 2013 14:12:13 -0500
Message-ID: <329F7C2C-F1DA-4025-977F-5C09A9BFE21D@kernel.crashing.org>
References: <1363200580-11623-1-git-send-email-Varun.Sethi@freescale.com>
	<0080B56D-8417-41B9-8341-665457D04DE6@kernel.crashing.org>
	<C5ECD7A89D1DC44195F34B25E172658D40ABB4@039-SN2MPN1-013.039d.mgd.msft.net>
	<CCCE947A-1C24-40C2-9341-BBF3F5C00D98@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CCCE947A-1C24-40C2-9341-BBF3F5C00D98-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


On Mar 18, 2013, at 9:59 AM, Kumar Gala wrote:

> 
> On Mar 17, 2013, at 10:48 AM, Sethi Varun-B16395 wrote:
> 
>>>> 
>>>> +	guts_node = of_find_compatible_node(NULL, NULL,
>>>> +			"fsl,qoriq-device-config-1.0");
>>> 
>>> This doesn't work for T4 or B4 device trees.
>>> 
>> [Sethi Varun-B16395]hmm.... I need to use the dcfg space for this.
> 
> Let's see with the SoC arch's if something like "fsl,qoriq-device-config-2.0" makes sense for T4 & B4.

Based on discuss, I've sent patch for T4 dts to use "fsl,qoriq-device-config-2.0", so please update PAMU code to use that string.

- k
