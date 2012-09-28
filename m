From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] Intel IOMMU patch to reprocess RMRR info
Date: Fri, 28 Sep 2012 11:43:01 +0200
Message-ID: <20120928094301.GH10549@amd.com>
References: <20120918164955.12296.28799.sendpatchset@tmingo.houston.hp.com>
	<1348778200.2320.241.camel@ul30vt.home>
	<9774516974AF5F4C8A2C3C69CD3412332338F452@G1W3651.americas.hpqcorp.net>
	<1348781647.2320.264.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1348781647.2320.264.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
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

On Thu, Sep 27, 2012 at 03:34:07PM -0600, Alex Williamson wrote:

> It really seems like RMRRs are incompatible with IOMMU API use
> though.

I don't think so. The concept of RMRR is just not defined well enough
(like the concept of unity mappings on the AMD side which is similar to
 RMRR). The definition says, that any memory region must be mapped at
any time for the device. But that is not true (at least I have no
counter-example yet). The right definition would be, that the RMRR
regions are only necessary as long as the operating system does not
control the particular device. And assigning a device to a guest also
counts a 'taking control over the device'.


	Joerg
