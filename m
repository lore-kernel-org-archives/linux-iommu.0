From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 08/11] of: Increase MAX_PHANDLE_ARGS
Date: Fri, 31 Jan 2014 00:18:45 +0000
Message-ID: <20140131001845.GB5525@mudshark.cambridge.arm.com>
References: <20140117110830.GW3471@alberich> <52E92842.3000001@amd.com>
	<CAL_JsqLhzp5jUJPA91rNkQ07kCDYCDZLxw8LxxFEVP9b12e1Jw@mail.gmail.com>
	<52E93360.1000904@amd.com> <20140129171611.GB13543@alberich>
	<52E939CB.1020705@amd.com>
	<20140129172932.GQ26622@mudshark.cambridge.arm.com>
	<52E940FC.9050602@amd.com>
	<20140129180350.GS26622@mudshark.cambridge.arm.com>
	<52EAD7EF.3040305@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52EAD7EF.3040305-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 30, 2014 at 10:53:35PM +0000, Suravee Suthikulanit wrote:
> On 1/29/2014 12:03 PM, Will Deacon wrote:
> > Interesting... how does that work for PCI? Do you force all devices behind a
> > given RC into the same address space?
> >
> 
> For PCI devices, we are using the bus, device, and function id to make 
> up the 15-bit SID for devices behind a particular PCI root complex.

Very good!

> I also notice that we are currently not supporting the streamID mask in 
> the SMR.  Is this something planed for the future?

Andreas and I are curently working on this -- that's what I was referring to
above. Any feedback from you would be welcomed.

Will
