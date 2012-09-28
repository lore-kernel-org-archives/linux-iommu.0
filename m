From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] Intel IOMMU patch to reprocess RMRR info
Date: Fri, 28 Sep 2012 14:52:46 +0200
Message-ID: <20120928125246.GK10549@amd.com>
References: <20120918164955.12296.28799.sendpatchset@tmingo.houston.hp.com>
	<1348778200.2320.241.camel@ul30vt.home>
	<9774516974AF5F4C8A2C3C69CD3412332338F452@G1W3651.americas.hpqcorp.net>
	<1348781647.2320.264.camel@ul30vt.home>
	<20120928094301.GH10549@amd.com>
	<1348836008.2320.284.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1348836008.2320.284.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Khan, Shuah" <shuah.khan-VXdhtT5mjnY@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Mingarelli,
	Thomas" <Thomas.Mingarelli-VXdhtT5mjnY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 28, 2012 at 06:40:08AM -0600, Alex Williamson wrote:
> On Fri, 2012-09-28 at 11:43 +0200, Joerg Roedel wrote:

> > I don't think so. The concept of RMRR is just not defined well enough
> > (like the concept of unity mappings on the AMD side which is similar to
> >  RMRR). The definition says, that any memory region must be mapped at
> > any time for the device. But that is not true (at least I have no
> > counter-example yet). The right definition would be, that the RMRR
> > regions are only necessary as long as the operating system does not
> > control the particular device. And assigning a device to a guest also
> > counts a 'taking control over the device'.
> 
> I think HP folks would be very unhappy with that definition.  As David
> indicates, that's how things like USB use RMRR, but the actual
> definition in the spec leaves much more room for abuse.  Thanks,

To my experience, for a hardware designer, existing software overrides
any Spec because it is much worse to break existing software than it is
to break a Spec :) So, unless we break existing hardware/firmware, I
still suggest that we use the assumption that OS controlled devices do
not need RMRR/unity-mapped regions anymore.

Is HP doing anything in their firmware which would not work with that?

For the USB controlers, they only generate DMA to the RMRR/unity-mapped
region until the OS takes over control from the firmware. After
the USB driver is initialized the RMRR region should not be necessary
anymore.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
