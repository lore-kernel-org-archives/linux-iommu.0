From: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/1] iova: Allow compiling the library without IOMMU
	support
Date: Thu, 3 Jan 2019 15:33:20 -0600 (CST)
Message-ID: <1276926960.401168.1546551200268.JavaMail.zimbra@xes-inc.com>
References: <20190102211657.13192-1-sakari.ailus@linux.intel.com>
	<12009133.IFJkWA3Ofo@avalon>
	<20190103201126.zzqpn2eylm4m2zxn@mara.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190103201126.zzqpn2eylm4m2zxn-WV0MzMiPiMJ82hYKe6nXyg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, hans verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, rajmohan mani <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, bingbu cao <bingbu.cao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tian shu qiu <tian.shu.qiu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, yong zhi <yong.zhi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

----- Original Message -----
> From: "Sakari Ailus" <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Sent: Thursday, January 3, 2019 2:11:27 PM

Hi Laurent and Sakari,

I don't have much else to offer here, but wanted to second Sakari's
use case below.

> Hi Laurent,
> 
> On Thu, Jan 03, 2019 at 12:52:00AM +0200, Laurent Pinchart wrote:
>> Hi Sakari,
>> 
>> Thank you for the patch.
>> 
>> On Wednesday, 2 January 2019 23:16:57 EET Sakari Ailus wrote:
>> > Drivers such as the Intel IPU3 ImgU driver use the IOVA library to manage
>> > the device's own virtual address space while not implementing the IOMMU
>> > API.
>> 
>> Why is that ? Could the IPU3 IOMMU be implemented as an IOMMU driver ?
> 
> You could do that, but:
> 
> - it's a single PCI device so there's no advantage in doing so and

I also use the IOVA library for a PCI device (PCIe-VME bridge) that has
IOMMU features, but isn't a general purpose IOMMU. I am eagerly following
along.

-Aaron

> - doing that would render the device inoperable if an IOMMU is enabled in
>  the system, as chaining IOMMUs is not supported in the IOMMU framework
>  AFAIK.
> 
>> 
>> > Currently the IOVA library is only compiled if the IOMMU support is
>> > enabled, resulting into a failure during linking due to missing symbols.
>> > 
>> > Fix this by defining IOVA library Kconfig bits independently of IOMMU
>> > support configuration, and descending to the iommu directory
>> > unconditionally during the build.
>> > 
>> > Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
