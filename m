From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFT] iommu/amd: use subsys_initcall() on amdv2 iommu
Date: Wed, 16 Mar 2016 18:17:19 +0100
Message-ID: <20160316171719.GE2195@8bytes.org>
References: <1458079926-18716-1-git-send-email-mcgrof@kernel.org>
	<CAFCwf13RT9VyzhJ4AhAGd1ndd8f=Cd0TRnnRcDwBGHbOzyc5BQ@mail.gmail.com>
	<20160316101457.GC2195@8bytes.org>
	<CAFCwf13LM+snV1Hi+hE4yHHRKRTzoySNHNesM+2vxAKFYzvqVg@mail.gmail.com>
	<20160316161736.GL1990@wotan.suse.de>
	<20160316163900.GD2195@8bytes.org>
	<20160316165747.GN1990@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160316165747.GN1990-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 16, 2016 at 05:57:47PM +0100, Luis R. Rodriguez wrote:
> I'm afraid I am not sure where that hack is, can someone construct a patch to
> revert that so this is a proper RFT series ?

Oded mentioned 1bacc894c227fad8a727eb99728df708eba57654, which reverts
fine here on v4.5.


	Joerg
