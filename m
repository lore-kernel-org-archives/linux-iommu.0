From: "Zhi, Yong" <yong.zhi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v4 00/12] Intel IPU3 ImgU patchset
Date: Mon, 23 Oct 2017 21:24:50 +0000
Message-ID: <C193D76D23A22742993887E6D207B54D1AE2BC75@ORSMSX106.amr.corp.intel.com>
References: <1508298408-25822-1-git-send-email-yong.zhi@intel.com>
	<20171020090949.nhv74sfb5jjrtxhx@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171020090949.nhv74sfb5jjrtxhx-S+BSfZ9RZZmRSg0ZkenSGLdO1Tsj/99ntUK59QYPAWc@public.gmane.org>
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
To: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Cc: "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "Hu, Jerry W" <jerry.w.hu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Zheng, Jian Xu" <jian.xu.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Toivonen, Tuukka" <tuukka.toivonen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Mani,
	Rajmohan" <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>, "linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi, Sakari,

> -----Original Message-----
> From: linux-media-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-media-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Sakari Ailus
> Sent: Friday, October 20, 2017 2:10 AM
> To: Zhi, Yong <yong.zhi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org; Zheng, Jian
> Xu <jian.xu.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Mani, Rajmohan
> <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Toivonen, Tuukka
> <tuukka.toivonen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Hu, Jerry W <jerry.w.hu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>;
> arnd-r2nGTMty4D4@public.gmane.org; hch-jcswGhMUV9g@public.gmane.org; robin.murphy-5wv7dgnIgG8@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org
> Subject: Re: [PATCH v4 00/12] Intel IPU3 ImgU patchset
> 
> Hi Yong,
> 
> On Tue, Oct 17, 2017 at 10:46:48PM -0500, Yong Zhi wrote:
> > This patchset adds support for the Intel IPU3 (Image Processing Unit)
> > ImgU which is essentially a modern memory-to-memory ISP. It implements
> > raw Bayer to YUV image format conversion as well as a large number of
> > other pixel processing algorithms for improving the image quality.
> >
> > Meta data formats are defined for image statistics (3A, i.e. automatic
> > white balance, exposure and focus, histogram and local area contrast
> > enhancement) as well as for the pixel processing algorithm parameters.
> > The documentation for these formats is currently not included in the
> > patchset but will be added in a future version of this set.
> >
> > The algorithm parameters need to be considered specific to a given
> > frame and typically a large number of these parameters change on frame
> > to frame basis. Additionally, the parameters are highly structured
> > (and not a flat space of independent configuration primitives). They
> > also reflect the data structures used by the firmware and the
> > hardware. On top of that, the algorithms require highly specialized
> > user space to make meaningful use of them. For these reasons it has
> > been chosen video buffers to pass
> 
> Do you have a to-do list for this patchset? I think it would be useful to
> maintain one, in case not all the comments have been addressed.
> 

Sure, will add in next update.

> --
> Sakari Ailus
> e-mail: sakari.ailus-X3B1VOXEql0@public.gmane.org
