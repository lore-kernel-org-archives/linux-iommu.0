From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two
	devices
Date: Wed, 14 Mar 2018 20:50:54 +0900
Message-ID: <CAAFQd5CQXY0Efv+2MC1kTVW5q4eZjJ=gwVaR-LA=3agnSSHzUw@mail.gmail.com>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
	<CAFp+6iH3R2j0_vboSV6-0k7vQFaZ66iNiTcV3_qSbBGXdM=S_A@mail.gmail.com>
	<CAAFQd5A5Rj1KAZjUc5ZUKuKnbkA5Q6aLw9z0H3_kfyBQOOF-gw@mail.gmail.com>
	<2217404.A2W3Iek6du@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2217404.A2W3Iek6du-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 14, 2018 at 8:12 PM, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
> On Tuesday, March 13, 2018 12:23:34 PM CET Tomasz Figa wrote:
>> On Tue, Mar 13, 2018 at 7:34 PM, Vivek Gautam
>> <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>> > Hi Tomasz,
>> >
>> > On Tue, Mar 13, 2018 at 3:45 PM, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>> >> Hi Vivek,
>> >>
>> >> Thanks for the patch.
>> >>
>> >> On Tue, Mar 13, 2018 at 5:55 PM, Vivek Gautam
>> >> <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>> >>> The lists managing the device-links can be traversed to
>> >>> find the link between two devices. The device_link_add() APIs
>> >>> does traverse these lists to check if there's already a link
>> >>> setup between the two devices.
>> >>> So, add a new APIs, device_link_find(), to find an existing
>> >>> device link between two devices - suppliers and consumers.
>> >>
>> >> I'm wondering if this API would be useful for anything else that the
>> >> problem we're trying to solve with deleting links without storing them
>> >> anywhere. Perhaps a device_link_del_dev(consumer, supplier) would be a
>> >> better alternative?
>> >
>> > Yea, that sounds simpler i think. Will add this API instead of
>> > find_link(). Thanks.
>>
>> Perhaps let's wait for a moment to see if there are other opinions. :)
>>
>> Rafael, Lucas, any thoughts?
>
> It is not clear to me what the device_link_del_dev(consumer, supplier) would do.

It would delete a link between consumer and supplier.

Best regards,
Tomasz
