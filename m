From: Avi Kivity <avi-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] vfio: Include no-iommu mode
Date: Mon, 12 Oct 2015 19:31:10 +0300
Message-ID: <561BE04E.4030108@scylladb.com>
References: <20151009182228.14752.99700.stgit@gimli.home>
	<20151009184110.14752.53531.stgit@gimli.home>
	<20151012085607.2c64f98f@urahara>
	<1444666999.4059.362.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1444666999.4059.362.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Stephen Hemminger <stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org>
Cc: avi-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org, gleb-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org, mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bruce.richardson-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gleb-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org, vladz-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, hjk-vqZO0P4V72/QD6PfKP4TzA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 10/12/2015 07:23 PM, Alex Williamson wrote:
>> Also, although you think the long option will set the bar high
>> enough it probably will not satisfy anyone. It is annoying enough, that
>> I would just carry a patch to remove it the silly requirement.
>> And the the people who believe
>> all user mode DMA is evil won't be satisfied either.
> I find that many users blindly follow howtos and only sometimes do they
> question the options if they sound scary enough.  So yeah, I would
> intend to make the option upstream sound scary enough for people to
> think twice about using it and maybe even read the description.  That
> still doesn't prevent pasting it into modprobe.d and forgetting about
> it.

I think we need to allow for packages to work with this.  I.e. drop 
files into config directories rather than require editing of config 
files.  I think this is mostly workable via modprobe.d.

(for our own use case, we don't require the extreme performance of many 
L2/L3 dpdk apps so we'll work with regular iommued vfio for bare-metal 
installations and ship prebuilt virtual machine images for clouds, so it 
doesn't matter that much to me).
